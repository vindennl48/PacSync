#!/bin/bash

# An array of packages required by this module.
# The main script will ensure these are installed.
packages=(
  neovim
  gcc
  curl
  wget
  fzf
  ripgrep
  fd
)

# The main function that will be executed by the sync script
# after all packages have been installed.
install() {
  echo "----> Setting up LazyVim..."
  local user_home=$(getent passwd "$SUDO_USER" | cut -d: -f6)

  echo "      Making backups..."
  mv "${user_home}"/.config/nvim{,.bak} || true
  mv "${user_home}"/.local/share/nvim{,.bak} || true
  mv "${user_home}"/.local/state/nvim{,.bak} || true
  mv "${user_home}"/.cache/nvim{,.bak} || true
  sudo -u "$SUDO_USER" mkdir -p "${user_home}"/.config/nvim

  echo "      Cloning Repo..."
  sudo -u "$SUDO_USER" git clone https://github.com/LazyVim/starter "${user_home}"/.config/nvim
  rm -rf "${user_home}"/.config/nvim/.git

  # --- Customization ---
  # --- End Customization ---

  echo "----> LazyVim configuration complete!"
}

uninstall() {
  echo "----> Uninstalling LazyVim..."
  local user_home=$(getent passwd "$SUDO_USER" | cut -d: -f6)

  rm -rf "${user_home}"/.config/nvim || true
  rm -rf "${user_home}"/.local/share/nvim || true
  rm -rf "${user_home}"/.local/state/nvim || true
  rm -rf "${user_home}"/.cache/nvim || true

  mv "${user_home}"/.config/nvim.bak "${user_home}"/.config/nvim || true
  mv "${user_home}"/.local/share/nvim.bak "${user_home}"/.local/share/nvim || true
  mv "${user_home}"/.local/state/nvim.bak "${user_home}"/.local/state/nvim || true
  mv "${user_home}"/.cache/nvim.bak "${user_home}"/.cache/nvim || true

  echo "----> LazyVim uninstalled!"
}
