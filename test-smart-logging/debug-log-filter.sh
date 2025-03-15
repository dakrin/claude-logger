#!/usr/bin/env bash
#
# Debug script to inspect log files and test the filtering logic
#

LOG_FILE="$1"

if [ -z "$LOG_FILE" ]; then
  echo "Usage: $0 <path-to-log-file>"
  echo "Example: $0 /path/to/user/claude-logs/claude-20250315-163214-CLI-Interface-Preview.log"
  exit 1
fi

echo "=== ANALYZING LOG FILE: $LOG_FILE ==="
echo "File size: $(du -h "$LOG_FILE" | cut -f1)"
echo "Line count: $(wc -l < "$LOG_FILE")"
echo ""

echo "=== CHECKING FOR INPUT PATTERNS ==="
echo "Pattern: '>'"
PATTERN1_COUNT=$(grep -c ">" "$LOG_FILE")
echo "Found $PATTERN1_COUNT occurrences"

echo "Pattern: '│ >'"
PATTERN2_COUNT=$(grep -c "│ >" "$LOG_FILE")
echo "Found $PATTERN2_COUNT occurrences"

echo "Pattern: exit commands"
grep -n "exit" "$LOG_FILE" | head -10
echo ""

echo "=== EXTRACTING USER INPUTS ==="
echo "Lines with '> ' followed by content:"
grep -n "> " "$LOG_FILE" | grep -v "> $" | head -10
echo ""

echo "=== APPLYING REGEX FILTERS ==="
echo "Testing regex match patterns from has_meaningful_interaction():"

# Test a more robust input matching approach
echo "Lines matching improved pattern:"
echo "Looking for lines containing '> exit':"

# Use grep to find exit commands with box drawing characters
grep -n "> exit" "$LOG_FILE" | head -5

echo ""
echo "Using a simplified regex approach:"
while IFS= read -r line; do
  # Look for lines with "> exit" pattern
  if echo "$line" | grep -q "> exit"; then
    echo "FOUND EXIT LINE: $line"
  elif echo "$line" | grep -q "> " && ! echo "$line" | grep -q "> Try"; then
    content=$(echo "$line" | sed -E 's/.*> //')
    echo "FOUND OTHER INPUT: $content"
  fi
done < <(head -200 "$LOG_FILE")

echo ""
echo "=== RECOMMENDATION ==="
echo "Try updating the regex pattern in has_meaningful_interaction() to handle the specific format"
echo "in this log file. The current regex might not be correctly matching the '> exit' pattern"
echo "as it appears in this specific log format."