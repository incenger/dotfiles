#!/bin/bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

main() {
	# boilerplate
	setup_colors

	install_prerequisites

	install_neovim
	install_ctags

	install_shell

    config_tmux

}

cleanup() {
	trap - SIGINT SIGTERM ERR EXIT
	# script cleanup here
}

setup_colors() {
	if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
		NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
	else
		NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
	fi
}

msg() {
	echo >&2 -e "${1-}"
}

install_prerequisites() {
	# Basic tools
	apt update -y && apt install -y curl zsh git

	# For NVim
	apt install -y ripgrep
}

install_ctags() {
	msg "${GREEN}Installing ctags${NOFORMAT}"

	if command -v ctags &>/dev/null; then
		msg "${GREEN}ctags exists. Skip installation${NOFORMAT}" && return
	fi

	git clone https://github.com/universal-ctags/ctags.git ~/.local/ctags
	pushd ~/.local/ctags
	./autogen.sh
	./configure --prefix="$HOME/.local/ctags/build/"
	make && make install

	# Add ctags binary to $PATH
	msg "${GREEN}Update \$PATH in .zshenv ${NOFORMAT}"
	cat >>"${HOME}/.zshenv" <<'EOF'

# ctags
if [[ ! "$PATH" == *"$HOME/.local/ctags/build/bin"* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.local/ctags/build/bin"
fi
EOF
}

install_neovim() {
	NVIM_VERSION="0.8.1"
	msg "${GREEN}Installing NVim ${NVIM_VERSION}${NOFORMAT}"

	if command -v nvim &>/dev/null; then
		msg "${GREEN}nvim exists. Skip installation${NOFORMAT}" && return
	fi

	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		NVIM_RELEASE="nvim-linux64"
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		NVIM_RELEASE="nvim-macos"
	else
		msg "${RED}Unspported platform: ${OSTYPE} ${NOFORMAT}"
		return 1
	fi
	NVIM_URL="https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/${NVIM_RELEASE}.tar.gz"

	# Download and extract neovim
	msg "Download NVIM from: ${NVIM_URL}"

	curl -fLo "/tmp/nvim.tar.gz" "${NVIM_URL}"
	# Avoid "unknown developer" warning on MacOS
	if [[ "$NVIM_RELEASE" == "nvim-macos" ]]; then
		xattr -c "/tmp/nvim.tar.gz"
	fi
	mkdir -p "${HOME}/.local/"
	tar xzf "/tmp/nvim.tar.gz" -C "${HOME}/.local/"
	mv "${HOME}/.local/${NVIM_RELEASE}" "${HOME}/.local/nvim"

	msg "${GREEN}Update \$PATH in .zshenv ${NOFORMAT}"
	cat >>"${HOME}/.zshenv" <<'EOF'

# NVim
if [[ ! "$PATH" == *"$HOME/.local/nvim/bin"* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.local/nvim/bin"
fi
EOF
}

install_shell() {

	# oh-my-zsh needs the .zshrc to exist in the first place to avoid populating a new one.
	[[ -f "$HOME/.zshrc" ]] || curl -fLo "$HOME/.zshrc" "https://raw.githubusercontent.com/incenger/dotfiles/master/tmpl/.zshrc"

	install_fzf
	install_oh_my_zsh
	install_zsh_plugins
	install_powerlevel10k

	# Add config files
	[[ -f "$HOME/.p10k.zsh" ]] || curl -fLo "$HOME/.p10k.zsh" "https://raw.githubusercontent.com/incenger/dotfiles/master/tmpl/.p10k.zsh"
}

install_fzf() {
	msg "${GREEN}Install Fzf.${NOFORMAT}"
	if [[ -d $HOME/.fzf ]]; then
		msg "${GREEN}Fzf exists, skip installation.${NOFORMAT}" && return
	fi

	git clone --depth 1 "https://github.com/junegunn/fzf.git" "$HOME/.fzf"
	$HOME/.fzf/install --all
}

install_oh_my_zsh() {
	msg "${GREEN}Install Oh-my-zsh.${NOFORMAT}"
	if [[ -d $HOME/.oh-my-zsh ]]; then
		msg "${GREEN}Oh-my-zsh exists, skip installation.${NOFORMAT}" && return
	fi
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
}

install_powerlevel10k() {
	msg "${GREEN}Install Powerlevel10k.${NOFORMAT}"
	if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
		msg "${GREEN}Powerlevel10k exists, skip installation.${NOFORMAT}" && return
	fi

	git clone --depth=1 "https://github.com/romkatv/powerlevel10k.git" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
}

install_zsh_plugins() {
	msg "${GREEN}Install ZSH plugins.${NOFORMAT}"

	# zsh-syntax-highlighting
	msg "${GREEN}Install zsh-syntax-highlighting.${NOFORMAT}"
	if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
		msg "${GREEN}zsh-syntax-highlighting exists, skip installation.${NOFORMAT}"
	else
		git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
	fi

	# forgit
	msg "${GREEN}Install forgit.${NOFORMAT}"
	if [[ -d $HOME/.local/forgit ]]; then
		msg "${GREEN}forgit exists, skip installation.${NOFORMAT}" && return
	else
		git clone "https://github.com/wfxr/forgit.git" "$HOME/.local/forgit"
	fi

}

config_tmux() {
	msg "${GREEN}Install TPM.${NOFORMAT}"
	if [[ -d $HOME/.tmux/plugins/tpm ]]; then
		msg "${GREEN}TPM exists, skip installation.${NOFORMAT}"
	else
        git clone "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"
	fi

    # Add config files
	[[ -f "$HOME/.tmux.conf" ]] || curl -fLo "$HOME/.tmux.conf" "https://raw.githubusercontent.com/incenger/dotfiles/master/tmpl/.tmux.conf"
	[[ -f "$HOME/.tmux.theme" ]] || curl -fLo "$HOME/.tmux.theme" "https://raw.githubusercontent.com/incenger/dotfiles/master/tmpl/.tmux.theme"

}

main
