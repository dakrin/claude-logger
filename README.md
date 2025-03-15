# Claude Logger

A simple wrapper for Anthropic's Claude CLI that automatically logs conversations and summarizes them with intelligent file naming.

## Features

- Logs all Claude CLI conversations to timestamped files
- Automatically generates a concise 1-3 word summary of each conversation
- Renames log files to include the summary for easy identification
- Preserves all CLI arguments to Claude

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

Simply use `claude-log` instead of `claude`:

```bash
claude-log
```

All arguments are passed directly to Claude:

```bash
claude-log --cwd /path/to/project
```

When you exit Claude, the wrapper will:
1. Generate a 1-3 word summary of your conversation
2. Rename the log file to include this summary
3. Display the final log file path

All logs are saved in `~/claude-logs/` with filenames like:
```
claude-20250315-123456-project-refactoring.log
```

## License

MIT License

## Acknowledgements

- [Anthropic](https://www.anthropic.com/) - Creators of Claude