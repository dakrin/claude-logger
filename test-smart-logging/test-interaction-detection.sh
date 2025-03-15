#!/usr/bin/env bash
#
# Test script to validate the has_meaningful_interaction function
#

# Sample implementation of has_meaningful_interaction
test_has_meaningful_interaction() {
  local log_file="$1"
  local found_interaction=false
  local contains_exit=false
  
  echo "Testing log file: $log_file"
  
  # Check for exit command - handle box drawing characters
  if grep -q "> exit" "$log_file" || grep -q "│ > exit" "$log_file" || grep -q -P "\\│ > exit" "$log_file"; then
    contains_exit=true
    echo "✓ File contains exit command"
    
    # Show the exit command as found in the file
    echo "  Exit commands found:"
    grep -n "exit" "$log_file" | head -3
  else
    echo "✗ File does not contain exit command (or pattern not matched)"
    
    # Debug: show all occurrences of 'exit' in the file
    echo "  Occurrences of 'exit' in file:"
    grep -n "exit" "$log_file" | head -3
  fi
  
  # Then look for any meaningful input using grep
  # Handle both normal prompts and box-drawing characters
  # First, create a file with all prompts
  grep -E "(>|│ >) " "$log_file" > /tmp/prompts.txt
  
  # Filter out exit commands and suggestions
  if cat /tmp/prompts.txt | grep -v "exit" | grep -v "Try" | grep -v "> e$" | grep -v "> ex$" | grep -v "> exi$" | grep -q "."; then
    found_interaction=true
    echo "✓ File contains meaningful input"
    
    # Show what we found
    echo "  Meaningful inputs found:"
    cat /tmp/prompts.txt | grep -v "exit" | grep -v "Try" | grep -v "> e$" | grep -v "> ex$" | grep -v "> exi$" | head -5
  else
    echo "✗ File does not contain meaningful input"
    
    # Debug: show all prompt lines
    echo "  All prompt lines found:"
    cat /tmp/prompts.txt | head -5
  fi
  
  # Clean up
  rm -f /tmp/prompts.txt
  
  # If we have an exit command but no other meaningful input, it's an exit-only session
  if $contains_exit && ! $found_interaction; then
    echo "RESULT: EXIT-ONLY SESSION - should NOT be logged"
  elif $found_interaction; then
    echo "RESULT: MEANINGFUL SESSION - should be logged"
  else 
    echo "RESULT: INDETERMINATE - no exit and no meaningful input"
  fi
}

# Test against your specific log file
echo "=== TESTING DETECTION: TEST 1 ==="
test_has_meaningful_interaction "/path/to/user/claude-logs/claude-20250315-163214-CLI-Interface-Preview.log"
echo ""

# Find other logs to test with
echo "=== FINDING OTHER LOGS FOR TESTING ==="
echo "Looking for a log with meaningful interaction..."
MEANINGFUL_LOG=$(ls -t ~/claude-logs/claude-*.log | grep -v "Interface-Preview" | head -1)
if [ -n "$MEANINGFUL_LOG" ]; then
  echo "=== TESTING DETECTION: TEST 2 ==="
  test_has_meaningful_interaction "$MEANINGFUL_LOG"
fi