#!/usr/bin/env bash
#
# Test script to verify the --nolog option in claude-log
#

# Get log count before test
echo "Checking initial log count..."
INITIAL_COUNT=$(ls -1 ~/claude-logs | wc -l | tr -d ' ')

echo "TESTING: Regular session (should be logged)..."
echo -e "Tell me a joke\nexit" | ../claude-log

# Get log count after test
sleep 1  # Give a moment for any async operations to complete
AFTER_REGULAR_COUNT=$(ls -1 ~/claude-logs | wc -l | tr -d ' ')

# Check if a new log was created
if [ "$AFTER_REGULAR_COUNT" -gt "$INITIAL_COUNT" ]; then
  echo "✅ PASSED: Regular session was correctly logged (count increased from $INITIAL_COUNT to $AFTER_REGULAR_COUNT)"
  NEW_LOGS=$(ls -lt ~/claude-logs | head -2)
  echo "Most recent logs:"
  echo "$NEW_LOGS"
else
  echo "❌ FAILED: Regular session was not logged (count remained at $INITIAL_COUNT)"
fi

echo ""
echo "TESTING: Session with --nolog option (should NOT be logged)..."
echo -e "Tell me another joke\nexit" | ../claude-log --nolog

# Get log count after test
sleep 1  # Give a moment for any async operations to complete
AFTER_NOLOG_COUNT=$(ls -1 ~/claude-logs | wc -l | tr -d ' ')

# Check if a new log was created
if [ "$AFTER_NOLOG_COUNT" -eq "$AFTER_REGULAR_COUNT" ]; then
  echo "✅ PASSED: Session with --nolog was correctly not logged (count remained at $AFTER_REGULAR_COUNT)"
else
  echo "❌ FAILED: Session with --nolog was logged (count increased from $AFTER_REGULAR_COUNT to $AFTER_NOLOG_COUNT)"
  NEW_LOGS=$(ls -lt ~/claude-logs | head -2)
  echo "Most recent logs:"
  echo "$NEW_LOGS"
fi

echo ""
echo "Tests completed."