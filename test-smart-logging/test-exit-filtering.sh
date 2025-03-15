#!/usr/bin/env bash
#
# Test script to verify the exit-only session filtering in claude-log
#

# Get log count before test
echo "Checking initial log count..."
INITIAL_COUNT=$(ls -1 ~/claude-logs | wc -l | tr -d ' ')

echo "TESTING: Exit-only session..."
echo -e "exit" | ../claude-log

# Get log count after test
sleep 1  # Give a moment for any async operations to complete
AFTER_EXIT_COUNT=$(ls -1 ~/claude-logs | wc -l | tr -d ' ')

# Check if a new log was created
if [ "$AFTER_EXIT_COUNT" -gt "$INITIAL_COUNT" ]; then
  echo "❌ FAILED: Exit-only session was logged (count increased from $INITIAL_COUNT to $AFTER_EXIT_COUNT)"
  NEW_LOGS=$(ls -lt ~/claude-logs | head -2)
  echo "Most recent logs:"
  echo "$NEW_LOGS"
else
  echo "✅ PASSED: Exit-only session was correctly not logged"
fi

echo ""
echo "TESTING: Normal session with meaningful input..."
echo -e "What's the weather like today?\nexit" | ../claude-log

# Get log count after test
sleep 1  # Give a moment for any async operations to complete
AFTER_NORMAL_COUNT=$(ls -1 ~/claude-logs | wc -l | tr -d ' ')

# Check if a new log was created
if [ "$AFTER_NORMAL_COUNT" -gt "$AFTER_EXIT_COUNT" ]; then
  echo "✅ PASSED: Normal session was correctly logged (count increased from $AFTER_EXIT_COUNT to $AFTER_NORMAL_COUNT)"
  NEW_LOGS=$(ls -lt ~/claude-logs | head -2)
  echo "Most recent logs:"
  echo "$NEW_LOGS"
else
  echo "❌ FAILED: Normal session was not logged (count remained at $AFTER_EXIT_COUNT)"
fi

echo ""
echo "Tests completed."