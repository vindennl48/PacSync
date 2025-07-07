#!/bin/bash

# An array of packages required by this module.
# The main script will ensure these are installed.
packages=(
  spice-vdagent
  qemu-guest-agent
  xf86-video-qxl
)

# The main function that will be executed by the sync script
# after all packages have been installed.
install() {
  echo "----> Setting up QEMU Guest..."
  echo "----> QEMU Guest configuration complete!"
}

uninstall() {
  echo "----> Uninstalling QEMU Guest..."
  echo "----> QEMU Guest uninstalled!"
}
