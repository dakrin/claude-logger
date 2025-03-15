# Claude Logger

A wrapper for Anthropic's Claude CLI that automatically logs conversations, preserves color output, and summarizes conversations with intelligent file naming.

## Features

- **Auto-logging**: Logs all Claude CLI conversations to timestamped files
- **Color support**: Preserves Claude's colorized output in the terminal
- **Smart filtering**: Doesn't log sessions where you only type "exit" or nothing at all
- **Auto-summarizing**: Automatically generates a concise 1-3 word summary of each conversation
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
2. Captures all input and output to a log file
3. When Claude exits, checks if any meaningful conversation happened
4. If a real conversation occurred, generates a summary using Claude itself
5. Renames the log file with the generated summary

## Version History

- **1.2.0**: Added direct color support, smart filtering for exit-only sessions, and `--nolog` option
- **1.0.0**: Initial release

## License

MIT License

## Important Notes

- **API Usage**: This script makes a small additional API call to Claude when generating summaries. This may incur additional API costs depending on your usage and pricing plan.

## Acknowledgements

- [Anthropic](https://www.anthropic.com/) - Creators of Claude