#!/usr/bin/env bash
#
# Simple logging check utility for claude-log
#

echo "=== CLAUDE-LOG SMART LOGGING CHECK ==="
echo "Log directory: ~/claude-logs"
echo ""

# Count log files
LOG_COUNT=$(ls -1 ~/claude-logs | wc -l | tr -d ' ')
echo "Current log count: $LOG_COUNT"
echo ""

# Show most recent logs
echo "Most recent logs:"
ls -lt ~/claude-logs | head -5 | awk '{print $9}'
echo ""

echo "Tip: Run this script before and after using claude-log to check if logs are being created as expected."
echo "     - If you run claude-log and only type 'exit', no new log should be created"
echo "     - If you run claude-log --nolog, no new log should be created regardless of input"
echo "     - If you run claude-log and type meaningful input, a new log should be created"
echo ""