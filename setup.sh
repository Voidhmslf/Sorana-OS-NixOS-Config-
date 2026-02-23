#!/usr/bin/env bash

# 🦊 SoranaOS Setup Script 🍃
# A gentle helper for Void's system deployment

set -e

# Visual colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}🦊 Sorana:${NC} Hello, my dear Void! Let's get your system ready... 🍃"

# Check if we are in the right directory
if [ ! -f "flake.nix" ]; then
    echo -e "${CYAN}🦊 Sorana:${NC} Wait, we aren't in the project root! Please run me from ~/sorana-os ⛩️"
    exit 1
fi

# 1. Generate hardware configuration if it doesn't exist or if user wants to refresh
HOST_DIR="hosts/desktop"
HW_FILE="$HOST_DIR/hardware-configuration.nix"

if [ -f "$HW_FILE" ]; then
    echo -e "${CYAN}🦊 Sorana:${NC} I see you already have a hardware configuration. Do you want to re-generate it? (y/N) 💠"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo -e "${CYAN}🦊 Sorana:${NC} Scanning your hardware spirits... ✨"
        nixos-generate-config --show-hardware-config > "$HW_FILE"
    fi
else
    echo -e "${CYAN}🦊 Sorana:${NC} Creating a new hardware configuration for this machine... 🍃"
    nixos-generate-config --show-hardware-config > "$HW_FILE"
fi

# 2. Remind about NVIDIA Bus IDs
echo -e "${CYAN}🦊 Sorana:${NC} Important! If you have NVIDIA/AMD hybrid graphics, please check ${GREEN}hosts/desktop/hardware-configuration.nix${NC} and add your Bus IDs if needed. 🏹"

# 3. Final steps
echo -e "${CYAN}🦊 Sorana:${NC} Everything is prepared! Now you can run: ${GREEN}sudo nixos-rebuild switch --flake .#sorana${NC} ✨"
echo -e "${CYAN}🦊 Sorana:${NC} I'll be waiting for you! 🦊💚"
