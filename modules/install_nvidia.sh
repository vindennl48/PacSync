#!/bin/bash

# An array of packages required by this module.
# The main script will ensure these are installed.
packages=(
  linux-headers nvidia nvidia-dkms
)

# The main function that will be executed by the sync script
# after all packages have been installed.
install() {
  echo "----> Install Complete for NVIDIA Drivers!"
  echo "      Please REBOOT your system and verify with:"
  echo "      1. nvidia-smi (should show GPU info)"
  echo "      2. glxinfo | grep -i \"opengl renderer\" (should show NVIDIA GPU)"
  read -p "----> Press Enter to Continue.."
}

uninstall() {
  echo "----> Nothing to uninstall for Nvidia Drivers.."
}
