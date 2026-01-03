DOTFILES_DIR := $(shell pwd)

.PHONY: all keyd uninstall help

all:
	@echo "=== Installing dotfiles ==="
	ln -sf $(DOTFILES_DIR)/zsh/.zshrc $(HOME)/.zshrc
	ln -sf $(DOTFILES_DIR)/zsh/.zsh_aliases $(HOME)/.zsh_aliases
	ln -sfn $(DOTFILES_DIR)/claude $(HOME)/.claude
	ln -sf $(DOTFILES_DIR)/git/.gitconfig $(HOME)/.gitconfig
	mkdir -p $(HOME)/.config/fontconfig
	ln -sf $(DOTFILES_DIR)/fontconfig/fonts.conf $(HOME)/.config/fontconfig/fonts.conf
	@echo "=== Done ==="
	@echo ""
	@echo "Set git credentials:"
	@echo "  git config --global user.name 'Your Name'"
	@echo "  git config --global user.email 'your@email.com'"

keyd:
	@echo "=== Installing keyd config ==="
	sudo ln -sf $(DOTFILES_DIR)/keyd/default.conf /etc/keyd/default.conf
	sudo systemctl restart keyd
	@echo "=== Done ==="

uninstall:
	@echo "=== Removing symlinks ==="
	rm -f $(HOME)/.zshrc
	rm -f $(HOME)/.zsh_aliases
	rm -f $(HOME)/.claude
	rm -f $(HOME)/.gitconfig
	rm -f $(HOME)/.config/fontconfig/fonts.conf
	@echo "=== Done ==="

help:
	@echo "Usage:"
	@echo "  make          - Install dotfiles (zsh, git, claude)"
	@echo "  make keyd     - Install keyd config (requires sudo)"
	@echo "  make uninstall - Remove symlinks"
