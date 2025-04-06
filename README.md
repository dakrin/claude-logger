# Claude Logger

A wrapper for Anthropic's Claude CLI that automatically logs conversations, preserves color output, and summarizes conversations with intelligent file naming.

## Features

- **Auto-logging**: Logs all Claude CLI conversations to timestamped files
- **Color support**: Preserves Claude's colorized output in the terminal
- **Terminal title integration**: Uses the terminal window title in log filenames
- **Clean logs**: Strips ANSI color codes from log files for readability

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/user/claude-logger.git
   cd claude-logger
   ```

2. Make the script executable:
   ```bash
   chmod +x claude-log
   ```

3. Move to a directory in your PATH:
   ```bash
   # Option 1: Link to /usr/local/bin
   sudo ln -s "$(pwd)/claude-log" /usr/local/bin/claude-log
   
   # Option 2: Move to an existing bin directory
   cp claude-log ~/bin/
   ```

## Requirements

- Claude CLI installed and working
- Access to Anthropic's API

## Usage

### Basic Usage

Simply use `claude-log` instead of `claude`:

```bash
claude-log
```

All arguments are passed directly to Claude:

```bash
claude-log --cwd /path/to/project
```

### Command-line Options

- `--version` or `-v`: Display version information
  ```bash
  claude-log --version
  ```

- `--nolog`: Run Claude without logging (just passes through to Claude CLI)
  ```bash
  claude-log --nolog
  ```

When you exit Claude, the wrapper will:
1. Check if any meaningful conversation occurred (ignores sessions with just "exit" commands)
2. If a real conversation happened, it will:
   - Generate a 1-3 word summary of your conversation
   - Rename the log file to include this summary
   - Display the final log file path

All logs are saved in `~/claude-logs/` with filenames like:
```
claude-20250315-123456-project-refactoring.log
```

## How It Works

1. Runs Claude CLI in a pseudo-TTY to preserve color output
2. Captures all input and output to a log file, including ANSI escape sequences
3. Extracts the window title that Claude set during the session
4. Uses the extracted title in the log filename for context-aware naming
5. Saves the log with ANSI color codes removed for readability
6. Works across both macOS and Linux terminal environments

## Version History

- **1.3.6**: Improved window title extraction for both macOS and Linux
- **1.3.5**: Enhanced terminal title detection with escape sequence parsing
- **1.3.0**: Added terminal window title support for log filenames
- **1.2.1**: Added cross-platform compatibility for macOS and Linux
- **1.2.0**: Added direct color support, smart filtering for exit-only sessions, and `--nolog` option
- **1.0.0**: Initial release

## License

MIT License

## Important Notes

- **Terminal Title**: This script uses your terminal window title to name log files. If your terminal automatically updates window titles based on conversation topics, this will create context-aware log filenames without any additional API calls.

## Acknowledgements

- [Anthropic](https://www.anthropic.com/) - Creators of Claude