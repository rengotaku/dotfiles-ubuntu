# Dotfiles 設計書

## 概要

takuya の開発環境設定を一元管理する dotfiles リポジトリの設計。

## ディレクトリ構成

```
~/dotfiles/
├── .gitignore              # セキュリティ設定済み
├── LICENSE                 # 既存
├── README.md               # 新規作成
├── Makefile                # シンボリックリンク作成
├── claudedocs/             # 設計・分析ドキュメント
│   └── dotfiles-design.md  # 本ファイル
├── zsh/
│   └── .zshrc              # Oh My Zsh 設定
├── keyd/
│   └── default.conf        # Mac-like キーバインド設定
├── git/
│   └── .gitconfig          # Git 設定（機密情報除外）
└── claude/                 # SuperClaude framework (git submodule)
    ├── settings.json
    ├── CLAUDE.md
    ├── core/
    ├── modes/
    ├── mcp/
    ├── commands/
    └── agents/
```

## コンポーネント詳細

### zsh/.zshrc

| 項目 | 値 |
|------|-----|
| シェル | Zsh + Oh My Zsh |
| テーマ | robbyrussell |
| プラグイン | git, docker, zsh-autosuggestions, zsh-syntax-highlighting, z |
| リンク先 | `~/.zshrc` |

### keyd/default.conf

| 項目 | 値 |
|------|-----|
| 目的 | Mac-like キーバインド |
| 主要設定 | leftalt → Cmd キー化、CapsLock → F17 |
| リンク先 | `/etc/keyd/default.conf` |
| 権限 | 要 sudo |

### git/.gitconfig

| 項目 | 値 |
|------|-----|
| 除外項目 | user.name, user.email（ローカル設定で上書き） |
| リンク先 | `~/.gitconfig` |

```gitconfig
[core]
    editor = vim
    autocrlf = input

[init]
    defaultBranch = main

[pull]
    rebase = true

[alias]
    st = status
    co = checkout
    br = branch
    lg = log --oneline --graph --decorate
```

### claude/

| 項目 | 値 |
|------|-----|
| 内容 | SuperClaude framework |
| リンク先 | `~/.claude` (ディレクトリ全体) |

## Makefile 設計

```makefile
DOTFILES_DIR := $(shell pwd)

.PHONY: all keyd uninstall help

all:
	ln -sf $(DOTFILES_DIR)/zsh/.zshrc $(HOME)/.zshrc
	ln -sfn $(DOTFILES_DIR)/claude $(HOME)/.claude
	ln -sf $(DOTFILES_DIR)/git/.gitconfig $(HOME)/.gitconfig

keyd:
	sudo ln -sf $(DOTFILES_DIR)/keyd/default.conf /etc/keyd/default.conf
	sudo systemctl restart keyd

uninstall:
	rm -f $(HOME)/.zshrc
	rm -f $(HOME)/.claude
	rm -f $(HOME)/.gitconfig
```

## シンボリックリンク一覧

| ソース | リンク先 | 権限 |
|--------|----------|------|
| `zsh/.zshrc` | `~/.zshrc` | user |
| `git/.gitconfig` | `~/.gitconfig` | user |
| `claude/` | `~/.claude` | user |
| `keyd/default.conf` | `/etc/keyd/default.conf` | root |

## セキュリティ考慮事項

### .gitignore 設定済み項目

```
# Credentials & secrets
*.credentials*
*secret*
*token*
.env

# Claude sensitive files
claude/.credentials.json

# SSH keys
*.pem
id_*
*.pub
```

### 機密情報の扱い

| 項目 | 対応 |
|------|------|
| Git user.name/email | .gitconfig に含めず、ローカル設定で上書き |
| API キー | .gitignore で除外 |
| SSH 鍵 | .gitignore で除外 |

## 実装手順

1. ディレクトリ作成: `zsh/`, `keyd/`, `git/`
2. 設定ファイルコピー: 既存設定を各ディレクトリに配置
3. Makefile 作成
4. README.md 作成
5. テスト: 新規環境でインストール確認

## 決定事項

- **keyd の扱い**: `make install-keyd` で別途適用
- **.gitconfig**: 機密情報除外、ローカル設定で上書き方式
