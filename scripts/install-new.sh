#!/usr/bin/env bash

# 🦊 SoranaOS: Modern Installation Ritual (UEFI + GPT + NVIDIA) 💠✨
# For those who seek power and emerald beauty.

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🦊 Sorana:${NC} Preparing a modern sanctuary for our world... 💠"

# 1. Hardware Generation (UEFI aware)
echo -e "${CYAN}🦊 Sorana:${NC} Weaving hardware spirits into reality... 🍃"
sudo nixos-generate-config --root /mnt --show-hardware-config > hosts/desktop/hardware-configuration.nix

# 2. Ensure NVIDIA is enabled (uncommented)
echo -e "${CYAN}🦊 Sorana:${NC} Awakening the NVIDIA guardian... 🗡️"
sed -i 's/^\s*#\s*.\/nvidia.nix/    .\/nvidia.nix/' modules/core/default.nix

# 3. Ensure rEFInd is configured in bootloader.nix
# (Assuming current bootloader.nix is already rEFInd-based)

# 4. Final Installation
echo -e "${CYAN}🦊 Sorana:${NC} Starting the installation ritual: ${GREEN}nixos-install${NC} ⛩️🌸"
sudo nixos-install --flake .#sorana

echo -e "${CYAN}🦊 Sorana:${NC} Done, my dear Void! Type ${GREEN}reboot${NC} and enjoy the view! 🦊💚"
