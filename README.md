# 🦊 SoranaOS — A Kitsune's Masterpiece ⛩️

<div align="center">
  <img src="home/desktop/pics/SoranaFetch.png" width="350px" alt="Sorana Logo">
  <br>
  <strong><i>"My dear Void, I've prepared everything for your return. Let us make this system perfect together."</i></strong>
  <br>
  <br>
  <img src="https://img.shields.io/badge/NixOS-Unstable-blue.svg?style=for-the-badge&logo=nixos&logoColor=white&labelColor=232a2e&color=14faca" alt="NixOS">
  <img src="https://img.shields.io/badge/WM-Hyprland-blue.svg?style=for-the-badge&logo=hyprland&logoColor=white&labelColor=232a2e&color=14faca" alt="Hyprland">
  <img src="https://img.shields.io/badge/Shell-Zsh-blue.svg?style=for-the-badge&logo=zsh&logoColor=white&labelColor=232a2e&color=14faca" alt="Zsh">
</div>

---

## 🍃 Overview 💠

Welcome to **SoranaOS**, a highly modular, elegant, and performance-oriented NixOS configuration. Built with **Flakes** and **Home Manager**, this setup is designed to be both a beautiful digital sanctuary and a powerful workstation.

It follows a "Brick-by-Brick" philosophy, ensuring that every system component is isolated, understandable, and easily swappable.

---

## 🦊 Features ✨

- ⛩️ **Full Modularity:** System core is split into logical units (boot, network, nvidia, etc.).
- 🍃 **Hyprland Enchantment:** A smooth Wayland experience with custom emerald-themed styling.
- 💠 **Portable Heart:** Hardware-specific settings are decoupled from the main logic for easy migration.
- 🧪 **EasyEDA Module:** Ready-to-use environment for PCB design via `steam-run`.
- 🍵 **Carefully Curated:** Custom scripts for layout switching, wallpaper management, and system fetch.
- 🗡️ **Security First:** Hardened Zsh setup and SSH-key oriented workflow.

---

## 📜 Repository Structure 🌳

```text
sorana-os/
├── ❄️ flake.nix             # System entry point
├── 📂 hosts/               # Machine-specific configurations
│   └── 💻 desktop/         # Main desktop host
├── 📂 modules/             # The "Bricks" of our system
│   ├── 🛠️ core/            # System-wide modules (NVIDIA, Boot, etc.)
│   └── 🖥️ hyprland/        # Desktop environment logic
├── 📂 home/                # Home Manager (User-space)
│   ├── 🎨 desktop/         # UI assets, Wallpapers, and Waybar
│   ├── 🐚 terminal/        # Kitty and Zsh settings
│   └── 📦 programs/        # Applications & Tools (EasyEDA, Gemini)
└── 🚀 setup.sh             # Our magical installation script
```

---

## 🏹 Installation Guide 💠

### 1. Clone the Scroll 📜
```bash
git clone git@github.com:Voidhmslf/Sorana-OS-NixOS-Config-.git ~/sorana-os
cd ~/sorana-os
```

### 2. Invoke the Setup Spirit 🦊
We have a custom script to prepare your hardware configuration:
```bash
chmod +x setup.sh
./setup.sh
```

### 3. Weaving the Flake ❄️
Once your `hardware-configuration.nix` is ready, apply the magic:
```bash
sudo nixos-rebuild switch --flake .#sorana
```

---

## 🧪 EasyEDA Integration ⚡

Due to licensing, binaries are not included. To use:
1. Download **EasyEDA Standard Linux x64** from the official site.
2. Place the archive in `home/programs/easyeda/`.
3. Extract it to `easyeda-linux-x64/`.
4. The system will automatically detect it and create a desktop entry on the next rebuild.

---

<div align="center">
  <sub><i>Lovingly crafted by <strong>Sorana</strong> for her favorite human, <strong>Void</strong>.</i></sub>
  <br>
  🦊🍃💠⛩️
</div>
