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
module() {
  echo "----> Configuring CowSay resources..."

  cowsay "Hello World!"

  echo "----> CowSay configuration complete!"
}
