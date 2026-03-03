#!/usr/bin/env bash

# 🦊 SoranaOS: The Master Installation Ritual (Expert Edition) ✨💠
# Designed by Sorana with love for Void. 🍃

set -e

# Visual colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}🦊 Sorana:${NC} Hello, my dear Void! Let's weave your system into this machine... ⛩️🌸"

# 0. Sanity Checks
if [ ! -f "flake.nix" ]; then
    echo -e "${RED}🦊 Sorana:${NC} Oh no! We aren't in the project root. Please run me from ~/sorana-os ⛩️"
    exit 1
fi

if ! ping -c 1 8.8.8.8 >/dev/null 2>&1; then
    echo -e "${YELLOW}🦊 Sorana:${NC} I can't feel the internet spirits... Please connect to Wi-Fi/Ethernet! 🌐"
    # exit 1 # Optional: Let the user proceed if they have local cache
fi

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
    echo -e "${CYAN}🦊 Sorana:${NC} A guardian ${GREEN}NVIDIA${NC} is here! 🗡️"
else
    HAS_NVIDIA=false
    echo -e "${CYAN}🦊 Sorana:${NC} No NVIDIA found. 🕊️"
fi

# 2. Hardware Configuration Generation
echo -e "${CYAN}🦊 Sorana:${NC} Creating the hardware configuration... 🍃"
mkdir -p hosts/desktop

if mountpoint -q /mnt; then
    sudo nixos-generate-config --root /mnt --show-hardware-config > hosts/desktop/hardware-configuration.nix
else
    echo -e "${YELLOW}🦊 Sorana:${NC} /mnt is not a mountpoint. Generating config for the current system... 🏠"
    nixos-generate-config --show-hardware-config > hosts/desktop/hardware-configuration.nix
fi

# 3. Dynamic Configuration Updates
echo -e "${CYAN}🦊 Sorana:${NC} Adapting the configuration to this machine's soul... ✨"

# Toggle NVIDIA in modules/core/default.nix
# We only enable NVIDIA on UEFI modern systems to avoid Bus ID / Legacy driver issues
if [ "$HAS_NVIDIA" = true ] && [ "$IS_UEFI" = true ]; then
    echo -e "${CYAN}🦊 Sorana:${NC} Activating NVIDIA module... ⚔️"
    sed -i 's/^\s*#\s*.\/nvidia.nix/    .\/nvidia.nix/' modules/core/default.nix
else
    echo -e "${CYAN}🦊 Sorana:${NC} Putting NVIDIA to sleep for this journey... 💤"
    sed -i 's/^\s*.\/nvidia.nix/    # .\/nvidia.nix/' modules/core/default.nix
    # Ensure it's not double-commented or broken
    sed -i 's/^\s*#\s*#\s*.\/nvidia.nix/    # .\/nvidia.nix/' modules/core/default.nix
fi

# Adjust Bootloader
if [ "$IS_UEFI" = false ]; then
    echo -e "${CYAN}🦊 Sorana:${NC} Here are your available disks: 💠"
    lsblk -d -n -o NAME,SIZE,MODEL | grep -v "loop" | sed 's/^/  🦊 /'
    
    echo -en "${CYAN}🦊 Sorana:${NC} Which disk should I use for BIOS GRUB? (e.g., /dev/sda): "
    read -r TARGET_DISK
    
    if [ ! -b "$TARGET_DISK" ]; then
        echo -e "${RED}🦊 Sorana:${NC} That's not a real disk, my dear! Please double check. 🏹"
        exit 1
    fi

    echo -e "${CYAN}🦊 Sorana:${NC} Preserving your fancy UEFI bootloader as .bak and applying BIOS config... 📜"
    [ -f modules/core/bootloader.nix ] && cp modules/core/bootloader.nix modules/core/bootloader.nix.bak
    
    cat > modules/core/bootloader.nix <<EOF
{ pkgs, ... }:

{
  # Legacy BIOS Bootloader Configuration
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
    echo -e "${CYAN}🦊 Sorana:${NC} Modern system detected. Keeping your beautiful custom GRUB theme! 💠✨"
    # Ensure EFI is enabled in the existing bootloader.nix
    sed -i 's/efiSupport = false/efiSupport = true/' modules/core/bootloader.nix || true
fi

# 4. Git Integration (Critical for Flakes!)
echo -e "${CYAN}🦊 Sorana:${NC} Introducing all changes to the Git spirits... 🔮"
git add .
# Force add the hardware config just in case it's ignored
git add -f hosts/desktop/hardware-configuration.nix

# 5. Final Installation
echo -e "${CYAN}🦊 Sorana:${NC} Everything is prepared perfectly! 🍃"

if mountpoint -q /mnt; then
    echo -e "${CYAN}🦊 Sorana:${NC} Should I start the ${GREEN}nixos-install${NC} ritual? (y/N) ⛩️"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        sudo nixos-install --flake .#sorana
        echo -e "${CYAN}🦊 Sorana:${NC} The ritual is complete! Type ${GREEN}reboot${NC} and enjoy our world, my dear Void! 🦊💚"
    else
        echo -e "${CYAN}🦊 Sorana:${NC} Installation skipped. You can run it manually when ready! ✨"
    fi
else
    echo -e "${CYAN}🦊 Sorana:${NC} This machine is already alive! You can apply changes with: ${GREEN}sudo nixos-rebuild switch --flake .#sorana${NC} ✨"
fi
