#!/usr/bin/env bash

# 🦊 SoranaOS: Legacy Installation Ritual (BIOS + MBR + No-NVIDIA) 🍃🏹
# For the wise and seasoned veterans of the digital world.

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🦊 Sorana:${NC} Respecting the age of this machine... Let's breathe life into it! 🍃"

# 1. Hardware Generation (Legacy aware)
echo -e "${CYAN}🦊 Sorana:${NC} Aligning hardware spirits for a classic journey... 💠"
sudo nixos-generate-config --root /mnt --show-hardware-config > hosts/desktop/hardware-configuration.nix

# 2. Disable NVIDIA (comment out)
echo -e "${CYAN}🦊 Sorana:${NC} Putting NVIDIA to rest for this machine... 💤"
sed -i 's/^\s*.\/nvidia.nix/    # .\/nvidia.nix/' modules/core/default.nix

# 3. Switch to GRUB Legacy in bootloader.nix
echo -e "${CYAN}🦊 Sorana:${NC} Preparing the ancient GRUB incantations... 📜"
cat > modules/core/bootloader.nix <<EOF
{ pkgs, ... }:

{
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda"; # Assumes /dev/sda, change if needed!
    efiSupport = false;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
EOF

# 4. Final Installation
echo -e "${CYAN}🦊 Sorana:${NC} Starting the installation ritual: ${GREEN}nixos-install${NC} ⛩️🌸"
sudo nixos-install --flake .#sorana

echo -e "${CYAN}🦊 Sorana:${NC} Done, my dear Void! Type ${GREEN}reboot${NC} and let the past meet the future! 🦊💚"
