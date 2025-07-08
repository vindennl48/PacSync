#!/bin/bash

# An array of packages required by this module.
# The main script will ensure these are installed.
packages=(
  curl
  inetutils
)

# The main function that will be executed by the sync script
# after all packages have been installed.
install() {
  echo "----> Setting up Oh-My-Bash..."

  sudo -u "$SUDO_USER" bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

  # --- Customization ---
  local user_home=$(getent passwd "$SUDO_USER" | cut -d: -f6)
  sed -i 's/^OSH_THEME=.*/OSH_THEME="powerbash10k"/' "${user_home}/.bashrc"
  echo "export EDITOR=vim" >>"${user_home}/.bashrc"

  echo "alias vim='nvim'" >>"${user_home}/.bashrc"
  echo "alias vi='nvim'" >>"${user_home}/.bashrc"
  echo "alias v='nvim'" >>"${user_home}/.bashrc"
  # --- End Customization ---

  echo "----> Configuration Complete!"
}

uninstall() {
  echo "----> Uninstalling Oh-My-Bash..."

  (yes | sudo -u "$SUDO_USER" bash -i -c "uninstall_oh_my_bash") || true

  local user_home=$(getent passwd "$SUDO_USER" | cut -d: -f6)
  (sudo -u "$SUDO_USER" rm "$user_home"/.bashrc.*) || true

  echo "----> Uninstalled!"
}
