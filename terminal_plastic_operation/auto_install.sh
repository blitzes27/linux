#!/bin/bash

# Dont run this script with sudo
# This script is intended to be run as a normal user
# This script will install Oh My Bash, zoxide, and ble.sh
# It will also download a new .bashrc file from GitHub
# It will also install bat via apt
# It will also check if ~/.local/bin is in your PATH
set -euo pipefail

echo "Backing up current ~/.bashrc → ~/.bashrc_before_styling"
cp -v "$HOME/.bashrc" "$HOME/.bashrc_before_styling"

echo "Installing Oh My Bash"
cd ~ && bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

echo "Installing zoxide"
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

echo "Cloning ble.sh for syntax highlighting & autosuggestions"
git clone --recursive https://github.com/akinomyoga/ble.sh.git "$HOME/ble.sh"

sudo apt update
sudo apt install make -y
cd "$HOME/ble.sh" && make

echo "Downloading new .bashrc from GitHub"
curl -fsSL https://raw.githubusercontent.com/blitzes27/linux/main/terminal_plastic_operation/.bashrc \
  -o "$HOME/.bashrc"

echo "🔧 checking if ~/.local/bin is in your PATH"
if ! grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo "Installing bat via apt (requires sudo)"
sudo apt install -y bat

source "$HOME/.bashrc"
echo "Terminals plastic operation complete."
echo "check the bashrc file for your new aliases"
echo "You can now use the following commands:"
echo "  - ls: ls -a --color=auto"
echo "  - ls1: ls -lahtr --color=auto"
echo "  - cat: batcat"
echo "  - cd: z"