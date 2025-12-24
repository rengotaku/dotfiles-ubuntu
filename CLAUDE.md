# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository containing development environment configurations for Linux. Manages zsh, git, keyd (keyboard remapping), and Claude Code (SuperClaude framework) configurations via symlinks.

## Commands

```bash
# Install all dotfiles (creates symlinks)
make

# Install keyd keyboard config (requires sudo)
make keyd

# Remove all symlinks
make uninstall
```

## Architecture

### Symlink Structure

| Source | Target |
|--------|--------|
| `zsh/.zshrc` | `~/.zshrc` |
| `git/.gitconfig` | `~/.gitconfig` |
| `claude/` | `~/.claude` (directory symlink) |
| `keyd/default.conf` | `/etc/keyd/default.conf` |

### SuperClaude Framework (`claude/`)

The `claude/` directory is a complete Claude Code configuration that gets symlinked to `~/.claude`. It contains the SuperClaude framework with:

- `CLAUDE.md` - Entry point that imports framework components via `@` syntax
- `core/` - FLAGS.md, PRINCIPLES.md, RULES.md (behavioral configuration)
- `modes/` - Behavioral modes (Brainstorming, Introspection, Orchestration, Task Management, Token Efficiency)
- `mcp/` - MCP server documentation (Context7, Playwright, Serena, etc.)
- `agents/` - Specialized agent definitions
- `commands/` - Custom slash commands (`/git:*`, `/sc:*`)

The SuperClaude framework uses `@path/to/file.md` imports to compose the full CLAUDE.md from modular components.

### Keyd Configuration

Mac-like keyboard remapping for Linux:
- Left Alt → Cmd key behavior (with Ctrl-based shortcuts)
- CapsLock → F17
- Meta+Tab → Application switching

Requires: `gsettings set org.gnome.mutter overlay-key ''` to disable GNOME overlay.
