#!/bin/bash
#
# Module for installing and configuring cowsay

# An array of packages required by this module.
# The main script will ensure these are installed.
packages=(
  cowsay
)

# The main function that will be executed by the sync script
# after all packages have been installed.
install() {
  echo "----> Configuring CowSay resources..."

  cowsay "Hello World!"

  echo "----> CowSay configuration complete!"
}

uninstall() {
  echo "----> Uninstalling CowSay..."
  echo "----> CowSay uninstalled!"
}
