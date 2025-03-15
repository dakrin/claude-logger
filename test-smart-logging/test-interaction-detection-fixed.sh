#!/usr/bin/env bash
#
# Test script with simple line-by-line processing for better compatibility
#

# Sample implementation of has_meaningful_interaction
test_has_meaningful_interaction() {
  local log_file="$1"
  local found_interaction=false
  local found_exit=false
  
  echo "Testing log file: $log_file"
  
  # Create a more direct approach that doesn't rely on regex
  echo "Analyzing file line by line:"
  echo "- Looking for exit commands and meaningful input..."
  
  # Process file line by line - more reliable than regex
  while IFS= read -r line; do
    # Convert binary characters to hex for debugging
    hex_line=$(echo -n "$line" | hexdump -C | head -1)
    
    # Check if line contains exit command
    if [[ "$line" == *"> exit"* ]] || [[ "$line" == *"│ > exit"* ]]; then
      found_exit=true
      echo "  Found exit command: $line"
    fi
    
    # Check if line contains meaningful input (has prompt but not exit/Try)
    if [[ "$line" == *"> "* ]] && 
       [[ "$line" != *"> exit"* ]] && 
       [[ "$line" != *"│ > exit"* ]] && 
       [[ "$line" != *"> Try"* ]] && 
       [[ "$line" != *"│ > Try"* ]] && 
       [[ "$line" != *"> e"* ]] && 
       [[ "$line" != *"> ex"* ]] && 
       [[ "$line" != *"> exi"* ]]; then
      found_interaction=true
      echo "  Found meaningful input: $line"
    fi
  done < "$log_file"
  
  # Determine result
  if $found_exit && ! $found_interaction; then
    echo "RESULT: EXIT-ONLY SESSION - should NOT be logged"
  elif $found_interaction; then
    echo "RESULT: MEANINGFUL SESSION - should be logged"
  else 
    echo "RESULT: INDETERMINATE - no exit and no meaningful input"
  fi
}

# Test against your specific log file
echo "=== TESTING DETECTION: TEST 1 ==="
test_has_meaningful_interaction "$HOME/claude-logs/claude-20250315-163214-CLI-Interface-Preview.log"
echo ""

# Find other logs to test with
echo "=== FINDING OTHER LOGS FOR TESTING ==="
echo "Looking for a log with meaningful interaction..."
MEANINGFUL_LOG=$(ls -t ~/claude-logs/claude-*.log | grep -v "Interface-Preview" | head -1)
if [ -n "$MEANINGFUL_LOG" ]; then
  echo "=== TESTING DETECTION: TEST 2 ==="
  test_has_meaningful_interaction "$MEANINGFUL_LOG"
fi