#!/usr/bin/env bash
#
# Test script to verify file size-based detection logic
#

# Sample implementation of has_meaningful_interaction with size check
test_has_meaningful_interaction() {
  local log_file="$1"
  local found_interaction=false
  
  # Get file size
  local file_size=$(wc -c < "$log_file")
  
  # Threshold value based on observed file sizes
  local threshold=10000  # 10KB
  
  echo "File: $(basename "$log_file")"
  echo "Size: $file_size bytes"
  
  if [ "$file_size" -gt "$threshold" ]; then
    found_interaction=true
    echo "RESULT: MEANINGFUL SESSION (>10KB) - should be logged"
  else
    found_interaction=false
    echo "RESULT: SMALL SESSION (<10KB) - should NOT be logged"
  fi
  
  echo ""
}

# Test against all recent log files
echo "=== TESTING SIZE-BASED DETECTION ON RECENT LOGS ==="
echo ""

# Get list of recent log files
LOG_FILES=$(ls -t ~/claude-logs/claude-*.log | head -10)

# Test each file
for log_file in $LOG_FILES; do
  test_has_meaningful_interaction "$log_file"
done

echo "=== TESTING COMPLETE ==="