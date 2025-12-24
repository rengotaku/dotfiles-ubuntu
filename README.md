# dotfiles

Development environment configurations.

## Structure

```
dotfiles/
├── zsh/.zshrc          # Oh My Zsh configuration
├── git/.gitconfig      # Git configuration (no credentials)
├── keyd/default.conf   # Mac-like keybindings for Linux
├── claude/             # Claude Code configuration (SuperClaude)
└── Makefile
```

## Installation

```bash
git clone https://github.com/takuya/dotfiles.git ~/dotfiles
cd ~/dotfiles
make
```

### With keyd (requires sudo)

```bash
make keyd
```

### Uninstall

```bash
make uninstall
```

## Post-Installation

Set git credentials:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

## Symlinks

| Source | Target |
|--------|--------|
| `zsh/.zshrc` | `~/.zshrc` |
| `git/.gitconfig` | `~/.gitconfig` |
| `claude/` | `~/.claude` |
| `keyd/default.conf` | `/etc/keyd/default.conf` |

## Components

### Zsh

- Oh My Zsh with robbyrussell theme
- Plugins: git, docker, zsh-autosuggestions, zsh-syntax-highlighting, z

### Keyd

Mac-like keybindings:
- Left Alt → Cmd key behavior
- CapsLock → F17

### Claude

SuperClaude framework for enhanced Claude Code experience.
