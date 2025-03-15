#!/usr/bin/env bash
#
# Run all tests for claude-log
#

echo "===== CLAUDE-LOG TEST SUITE ====="
echo "Testing version: $(../claude-log --version | head -1)"
echo "============================"
echo ""

echo "TEST 1: Exit Filtering"
echo "---------------------"
./test-exit-filtering.sh
echo ""

echo "TEST 2: No-Log Option"
echo "---------------------"
./test-nolog-option.sh
echo ""

echo "============================"
echo "All tests completed."
echo "============================"