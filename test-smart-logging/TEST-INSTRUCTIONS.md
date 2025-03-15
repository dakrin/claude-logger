# Claude Logger - Manual Test Guide

This guide provides step-by-step instructions for testing the smart logging features of claude-log.

## Preparation

1. Open a terminal and navigate to the test directory:
   ```bash
   cd /path/to/user/Dev/claude-logger/test-smart-logging
   ```

2. Make sure all test scripts are executable:
   ```bash
   chmod +x *.sh
   ```

## Test 1: Exit-Only Session Filtering

This test verifies that claude-log doesn't log sessions where you only type "exit".

1. Check the current log count:
   ```bash
   ./check-logging.sh
   ```
   Note the current log count.

2. Run claude-log and only type "exit":
   ```bash
   ../claude-log
   ```
   
   When Claude starts, just type `exit` and press Enter.

3. Check if a new log was created:
   ```bash
   ./check-logging.sh
   ```
   
   **Expected result**: The log count should remain the same as before. No new log file should be created.

## Test 2: Normal Session Logging

This test verifies that claude-log correctly logs sessions with meaningful interaction.

1. Check the current log count:
   ```bash
   ./check-logging.sh
   ```
   Note the current log count.

2. Run claude-log and have a conversation:
   ```bash
   ../claude-log
   ```
   
   When Claude starts, type a question like "What's the weather today?", wait for a response, then type `exit`.

3. Check if a new log was created:
   ```bash
   ./check-logging.sh
   ```
   
   **Expected result**: The log count should increase by 1. A new log file should be created.

## Test 3: No-Log Option

This test verifies that the `--nolog` option correctly prevents logging.

1. Check the current log count:
   ```bash
   ./check-logging.sh
   ```
   Note the current log count.

2. Run claude-log with the `--nolog` option and have a conversation:
   ```bash
   ../claude-log --nolog
   ```
   
   When Claude starts, type a question like "Tell me a joke", wait for a response, then type `exit`.

3. Check if a new log was created:
   ```bash
   ./check-logging.sh
   ```
   
   **Expected result**: The log count should remain the same as before. No new log file should be created.

## Test 4: Color Display

This test verifies that color output is preserved in the terminal.

1. Run claude-log and check for colorized output:
   ```bash
   ../claude-log
   ```
   
   **Expected result**: The Claude welcome message, prompts, and other UI elements should be displayed in color.

## Test 5: Version Display

This test verifies that the version information is correctly displayed.

1. Check the version:
   ```bash
   ../claude-log --version
   ```
   
   **Expected result**: The version information should be displayed, including "Direct Color Support".

## Troubleshooting

If any tests fail, you can investigate:

- Check the script code in `/path/to/user/Dev/claude-logger/claude-log`
- Examine the log files in `~/claude-logs`
- Try running claude-log with different arguments

## Report Issues

If you find any bugs or issues, please report them at:
https://github.com/user/claude-logger/issues