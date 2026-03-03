#!/usr/bin/env bash

# 🦊 SoranaOS: The Universal Installation Ritual ✨💠
# Designed by Sorana with love for Void. 🍃

set -e

# Visual colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}🦊 Sorana:${NC} Hello, my dear Void! Let's weave your system into this machine... ⛩️🌸"

# 1. Hardware Detection
echo -e "${CYAN}🦊 Sorana:${NC} Scanning the hardware spirits... 🍃"

# Detect UEFI vs BIOS
if [ -d /sys/firmware/efi ]; then
    IS_UEFI=true
    echo -e "${CYAN}🦊 Sorana:${NC} I see a modern ${GREEN}UEFI${NC} spirit! 💠"
else
    IS_UEFI=false
    echo -e "${CYAN}🦊 Sorana:${NC} I feel an ancient ${GREEN}Legacy BIOS${NC} presence... 📜"
fi

# Detect NVIDIA GPU
if lspci | grep -qi nvidia; then
    HAS_NVIDIA=true
    echo -e "${CYAN}🦊 Sorana:${NC} A guardian ${GREEN}NVIDIA${NC} is here to protect us! 🗡️"
else
    HAS_NVIDIA=false
    echo -e "${CYAN}🦊 Sorana:${NC} No NVIDIA found. We will rely on other spirits... 🕊️"
fi

# 2. Hardware Configuration Generation
echo -e "${CYAN}🦊 Sorana:${NC} Creating the hardware configuration... 🍃"
# Ensure directory exists
mkdir -p hosts/desktop
# Use /mnt as root if running from installer, otherwise current system
if mountpoint -q /mnt; then
    sudo nixos-generate-config --root /mnt --show-hardware-config > hosts/desktop/hardware-configuration.nix
else
    nixos-generate-config --show-hardware-config > hosts/desktop/hardware-configuration.nix
fi

# IMPORTANT: Flakes need to see the file in git index!
echo -e "${CYAN}🦊 Sorana:${NC} Introducing the hardware spirit to Git... 🔮"
git add -f hosts/desktop/hardware-configuration.nix

# 3. Dynamic Configuration Updates
echo -e "${CYAN}🦊 Sorana:${NC} Adapting the configuration to this machine's soul... ✨"

# Toggle NVIDIA in modules/core/default.nix
if [ "$HAS_NVIDIA" = true ] && [ "$IS_UEFI" = true ]; then
    echo -e "${CYAN}🦊 Sorana:${NC} Enabling NVIDIA guardian... 🗡️"
    sed -i 's/^\s*#\s*.\/nvidia.nix/    .\/nvidia.nix/' modules/core/default.nix
else
    echo -e "${CYAN}🦊 Sorana:${NC} Disabling NVIDIA for this machine to avoid Bus ID errors... 💤"
    sed -i 's/^\s*.\/nvidia.nix/    # .\/nvidia.nix/' modules/core/default.nix
    sed -i 's/^\s*#\s*#\s*.\/nvidia.nix/    # .\/nvidia.nix/' modules/core/default.nix # Clean double comments
fi

# Adjust Bootloader (Legacy BIOS needs special care)
if [ "$IS_UEFI" = false ]; then
    echo -e "${CYAN}🦊 Sorana:${NC} Which disk should I use for BIOS GRUB? (e.g., /dev/sda): "
    read -r TARGET_DISK
    
    # Temporarily simplify bootloader for BIOS
    # (Your fancy Minecraft theme requires UEFI/GPT usually)
    cat > modules/core/bootloader.nix <<EOF
{ pkgs, ... }:

{
  boot.loader.grub = {
    enable = true;
    device = "${TARGET_DISK}";
    useOSProber = true;
    efiSupport = false;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
EOF
else
    echo -e "${CYAN}🦊 Sorana:${NC} UEFI detected. Keeping your beautiful custom GRUB theme! 💠✨"
    # Ensure it's in UEFI mode (usually the default in your repo)
    sed -i 's/efiSupport = false/efiSupport = true/' modules/core/bootloader.nix || true
fi

# 4. Final Installation
echo -e "${CYAN}🦊 Sorana:${NC} Everything is ready! 🍃"
echo -e "${CYAN}🦊 Sorana:${NC} If you are on a LiveUSB, should I start ${GREEN}nixos-install${NC}? (y/N) ⛩️"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    sudo nixos-install --flake .#sorana
    echo -e "${CYAN}🦊 Sorana:${NC} The ritual is complete! Type ${GREEN}reboot${NC} and enjoy our world, my dear Void! 🦊💚"
else
    echo -e "${CYAN}🦊 Sorana:${NC} Preparation done. You can run the install or rebuild whenever you're ready! ✨"
fi
