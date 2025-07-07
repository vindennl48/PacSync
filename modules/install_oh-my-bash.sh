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

  echo "----> Configuration Complete!"
}

uninstall() {
  echo "----> Uninstalling Oh-My-Bash..."

  uninstall_oh_my_bash

  echo "----> Uninstalled!"
}
