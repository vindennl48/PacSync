# PacSync: Declarative Package Management for Arch Linux

<div align="center">

![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg?style=for-the-badge)
![Maintained](https://img.shields.io/badge/Maintained%3F-Yes-green.svg?style=for-the-badge)
[![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge)](https://archlinux.org/)

A powerful Bash script that brings declarative, configuration-file-driven package management to your Arch Linux system. Define your desired state in a single config file, run the script, and let it handle the rest—from system updates to package synchronization, AUR management, and modular setups.

</div>

<br>

<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/supertassu/assets/main/pacsync/pacsync-dark-v2.svg">
    <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/supertassu/assets/main/pacsync/pacsync-light-v2.svg">
    <img alt="A terminal animation showing the pacsync script in action with colorful output." src="https://raw.githubusercontent.com/supertassu/assets/main/pacsync/pacsync-light-v2.svg">
  </picture>
</div>

---

## 📋 Table of Contents

-   [✨ Philosophy](#-philosophy)
-   [🚀 Features](#-features)
-   [🔧 Prerequisites](#-prerequisites)
-   [⚙️ Installation](#️-installation)
-   [💡 Usage](#-usage)
    -   [First Run: Generating Your Config](#first-run-generating-your-config)
    -   [The Configuration File (`packages.conf`)](#the-configuration-file-packagesconf)
    -   [Running the Sync](#running-the-sync)
    -   [Advanced: Using Modules](#advanced-using-modules)
-   [📁 Project Structure](#-project-structure)
-   [🧠 How It Works](#-how-it-works)
-   [🤝 Contributing](#-contributing)
-   [📜 License](#-license)

## ✨ Philosophy

Managing packages on Arch Linux is powerful, but it can be imperative and manual. You `pacman -S` new packages and occasionally `pacman -Rns` old ones. Over time, it's easy to forget exactly which packages you explicitly installed and why.

`pacsync` solves this by introducing a **declarative approach**. You don't tell the system *what to do*; you tell it *what the end state should be*. Your `packages.conf` file becomes the single source of truth for your system's software.

This makes your setup:
-   **Reproducible:** Easily set up a new machine to match your current one.
-   **Transparent:** See your entire curated software list at a glance.
-   **Clean:** The script automatically removes any packages installed on the system that are not declared in your config, keeping your system lean.

## 🚀 Features

-   **Declarative State:** Manage all your packages from a single, easy-to-read configuration file.
-   **Full System Sync:** Installs missing packages and removes extraneous ones to perfectly match your config.
-   **Official & AUR Support:** Seamlessly manages packages from both the official repositories (`pacman`) and the Arch User Repository (`yay`).
-   **Automated `yay` Installation:** If `yay` isn't found, the script will automatically install it for you.
-   **System Maintenance:**
    -   Performs a full system upgrade (`yay -Syu`) on every run.
    -   Cleans up orphan packages.
    -   Intelligently cleans package caches (`paccache` or `pacman`).
-   **Modular & Extensible:** Define "modules" for complex setups (like a desktop environment) that have their own package lists and custom installation/uninstallation scripts.
-   **Smart First Run:** Automatically generates a `packages.conf` file on its first run, pre-populated with all your currently installed explicit and AUR packages.

## 🔧 Prerequisites

-   An **Arch Linux**-based distribution.
-   `sudo` access.
-   `git` and `base-devel` (the script will attempt to install these if needed to build `yay`).

## ⚙️ Installation

1.  Clone this repository to your local machine. A common location is `~/pacsync`.

    ```bash
    git clone https://github.com/vindennl48/pacsync.git ~/pacsync
    cd ~/pacsync
    ```

2.  Make the script executable:

    ```bash
    chmod +x pacsync
    ```

That's it! The script is self-contained and ready to run.

## 💡 Usage

### First Run: Generating Your Config

The first time you run the script, it will see that you don't have a configuration file and will create one for you.

```bash
sudo ./pacsync
```

You will see output similar to this:
```
==> Configuration file not found. Creating a new one at /home/your-user/packages.conf...
==> File created successfully.
==> A new config file has been created.
==> Please review and edit /home/your-user/packages.conf before running this script again.
```
The script will then exit. **This is your chance to curate your system.**

Open the newly created `~/packages.conf` file. It will be pre-filled with every package you currently have explicitly installed. Go through this list and remove anything you don't want to keep. This is how you tell the script what your ideal system looks like.

### The Configuration File (`packages.conf`)

The `packages.conf` file is a simple Bash script that defines three arrays.

```bash
# ~/packages.conf

# ==========================================================
# My Arch Linux System - Maintained Packages & Modules
# ==========================================================

# --- An array of standard packages to be installed ---
# These can be from the official repos or groups like 'gnome'.
packages=(
  # --- Utilities ---
  'git'
  'vim'
  'htop'
  'pacman-contrib' # For paccache
  'btop'

  # --- GUI Apps ---
  'firefox'
  'vlc'
  'gimp'
)

# --- An array of packages from the Arch User Repository (AUR) ---
# These will be installed and managed by `yay`.
aur_packages=(
  'visual-studio-code-bin'
  'google-chrome'
)

# --- An array of custom modules to execute ---
# Corresponds to a file in the 'modules' subdirectory.
modules=(
  # 'install_plasma' # example
)
```

### Running the Sync

Once you are happy with your `packages.conf`, run the script again with `sudo`.

```bash
sudo ./pacsync
```

The script will now perform the full synchronization process:
1.  Update the entire system.
2.  Install any packages from your lists that are missing.
3.  **Uninstall any packages on your system that are NOT in your lists.**
4.  Handle module installation/uninstallation.
5.  Clean up orphans and caches.

### Advanced: Using Modules

Modules are a powerful feature for handling complex setups that require more than just installing a package. A module is a script that can define its own packages and custom `install` and `uninstall` logic.

**When to use a module?**
-   When you need to run `systemctl enable` after installing a service.
-   When you need to copy configuration files into place.
-   When you want to group a large set of packages and setup steps (e.g., a full Desktop Environment).

**How to create a module:**

1.  Create a new script file inside the `modules/` directory (e.g., `modules/install_cowsay.sh`).
2.  Inside this file, you can optionally define `packages` and `aur_packages` arrays.
3.  You **must** define an `install()` function. This runs once when the module is first added to your config.
4.  You **should** define an `uninstall()` function. This runs if the module is ever removed from your config.

**Example Module:** `modules/install_cowsay.sh`

```bash
#!/bin/bash
# Module for installing cowsay and a cool fortune message.

packages=(
  'cowsay'
  'fortune-mod'
)

install() {
  info "Module 'install_cowsay': Adding a welcome message to /etc/motd..."

  # Create a fun message of the day
  local motd_file="/etc/motd"
  echo "Welcome back, $(whoami)! Here is your fortune:" > "$motd_file"
  /usr/bin/fortune | /usr/bin/cowsay >> "$motd_file"

  success "MOTD updated!"
}

uninstall() {
  info "Module 'install_cowsay': Removing welcome message from /etc/motd..."
  # Clean up the file we created
  if [[ -f "/etc/motd" ]]; then
    rm /etc/motd
  fi
  success "MOTD cleaned up."
}
```

To enable this module, simply add its filename (without the extension) to the `modules` array in `packages.conf`:

```bash
# In ~/packages.conf
modules=(
  'install_cowsay'
)
```

The script keeps track of which modules have been installed in `~/modules.conf` to ensure the `install` and `uninstall` functions are only run when needed.

## 📁 Project Structure

```
your-repo/
├── pacsync                 # The main executable script.
├── modules/
│   ├── install_cowsay.sh   # Example module.
│   └── install_plasma.sh   # Another example module.
└── README.md               # This file.
```

Files created in the user's home directory:
```
~
├── packages.conf           # Your main package and module configuration.
└── modules.conf            # State file to track installed modules. Do not edit.
```

## 🧠 How It Works

The script follows a safe and logical execution order:

1.  **Initialization:** Checks for `sudo` permissions and locates the user's home directory to find the config files. If `packages.conf` is missing, it's created and the script exits.
2.  **Prerequisite Check:** Ensures `yay` is installed, installing it if necessary.
3.  **Configuration Loading:** Reads `packages.conf` and aggregates a master list of packages from both the main config and any enabled modules.
4.  **System Update:** Runs `yay -Syu` to bring the system fully up-to-date before making changes.
5.  **Package Sync (Official):**
    -   Installs all required official packages (`pacman -S --needed`).
    -   Compares the desired list against all explicitly installed packages (`pacman -Qeq`).
    -   Removes any packages that are installed but not on the desired list.
6.  **Package Sync (AUR):**
    -   Installs all required AUR packages (`yay -S --needed`).
    -   Compares the desired list against all installed AUR packages (`yay -Qemq`).
    -   Removes any AUR packages that are installed but not on the desired list.
7.  **Module Sync:**
    -   Compares the `modules` array in your config to the state file (`~/modules.conf`).
    -   Executes the `uninstall()` function for any modules that have been removed from the config.
    -   Executes the `install()` function for any new modules added to the config.
    -   Updates the state file.
8.  **Cleanup:**
    -   Removes all orphan packages.
    -   Cleans the pacman and yay caches to free up disk space.

## 🤝 Contributing

Contributions are welcome! If you have an idea for an improvement or find a bug, please feel free to:

1.  Fork the repository.
2.  Create a new feature branch (`git checkout -b feature/amazing-feature`).
3.  Commit your changes (`git commit -m 'Add some amazing feature'`).
4.  Push to the branch (`git push origin feature/amazing-feature`).
5.  Open a Pull Request.

## 📜 License

This project is licensed under the MIT License - see the LICENSE file for details.
