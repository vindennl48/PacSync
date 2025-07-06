#!/bin/bash

# An array of packages required by this module.
# The main script will ensure these are installed.
packages=(
  plasma-meta
)

# The main function that will be executed by the sync script
# after all packages have been installed.
install() {
  echo "----> Setting up Plasma Desktop Environment..."

  echo "      Starting sddm service..."
  sudo systemctl enable sddm.service
  sudo systemctl start sddm.service

  echo "----> Plasma configuration complete!"
}

uninstall() {
  echo "----> Uninstalling Plasma Desktop Environment..."
  sudo systemctl disable sddm.service
  echo "----> Plasma uninstalled!"
}
