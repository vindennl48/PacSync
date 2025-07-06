#!/bin/bash

# An array of packages required by this module.
# The main script will ensure these are installed.
packages=(
  openssh
)

# The main function that will be executed by the sync script
# after all packages have been installed.
install() {
  echo "----> Setting up OpenSSH..."

  echo "      Updating configuration..."
  CONFIG_FILE="/etc/ssh/sshd_config"
  KEY="KbdInteractiveAuthentication"
  VALUE="yes"

  # Create a backup before making any changes
  sudo cp "$CONFIG_FILE" "$CONFIG_FILE.bak"

  # Check if the key exists (commented or uncommented)
  if sudo grep -qE "^\s*#?\s*$KEY" "$CONFIG_FILE"; then
    # If it exists, uncomment it and set the correct value
    echo "--> Found $KEY, ensuring it is set to '$VALUE'..."
    sudo sed -i "s/^\s*#?\s*$KEY.*/$KEY $VALUE/" "$CONFIG_FILE"
  else
    # If it does not exist, add it to the end of the file
    echo "--> $KEY not found, adding it to $CONFIG_FILE..."
    echo "$KEY $VALUE" | sudo tee -a "$CONFIG_FILE" > /dev/null
  fi
  echo "      Configuration updated."

  echo "      Starting services..."
  sudo systemctl enable sshd.service
  sudo systemctl start sshd.service

  echo "      XRDP configuration complete!"
}

uninstall() {
  echo "----> Uninstalling OpenSSH..."

  sudo systemctl disable sshd.service

  echo "----> OpenSSH uninstalled!"
}
