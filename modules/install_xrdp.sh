#!/bin/bash

# An array of packages required by this module.
# The main script will ensure these are installed.
packages=(
  xrdp
  xorgxrdp
  pipewire-module-xrdp
)

# The main function that will be executed by the sync script
# after all packages have been installed.
install() {
  echo "----> Setting up XRDP Remote Desktop..."
  echo "      Starting services..."

  sudo systemctl enable xrdp.service
  sudo systemctl start xrdp.service

  echo "----> XRDP configuration complete!"
}

uninstall() {
  echo "----> Uninstalling XRDP Remote Desktop..."

  sudo systemctl disable xrdp.service

  echo "----> XRDP uninstalled!"
}
