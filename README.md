# 🦊 SoranaOS — A Kitsune's Masterpiece ⛩️

<div align="center">
  <img src="home/desktop/pics/SoranaPaper.png" width="600px" alt="Sorana OS Wallpaper">
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
- 🧪 **EasyEDA Integration:** Ready-to-use environment for PCB design via `steam-run`.
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
├── 📂 scripts/             # Automated installation scrolls 📜
│   ├── 💠 install-new.sh   # For UEFI/GPT/NVIDIA/rEFInd
│   └── 🍃 install-old.sh   # For BIOS/MBR/Legacy systems
└── 🚀 setup.sh             # Main setup helper for existing systems
```

---

## 🏹 Installation Guide 💠

### 1. Clone the Scroll 📜
```bash
git clone git@github.com:Voidhmslf/Sorana-OS-NixOS-Config-.git ~/sorana-os
cd ~/sorana-os
```

### 2. Invoke the Installation Spirit 🦊
Depending on your hardware, choose your ritual:

**For Modern Systems (UEFI/NVIDIA/GPT):**
```bash
chmod +x scripts/install-new.sh
./scripts/install-new.sh
```

**For Legacy Systems (BIOS/Intel/MBR):**
```bash
chmod +x scripts/install-old.sh
./scripts/install-old.sh
```

### 3. Weaving the Flake ❄️
Once the installation is finished and you've set your root password, reboot and enjoy!
```bash
reboot
```

---

## 🎨 Aesthetic Profile: Sorana's Embrace 🦊

The system is wrapped in a custom, static color palette designed for deep focus, visual comfort, and a touch of kitsune magic.

- **Theme:** *Sorana's Embrace* (Refined Velvet Edition)
- **UI Style:** Deep, rounded, and monolithic. Every application, from the terminal to the code editor, sings in harmony.

| Element | Color | Role |
| :--- | :---: | :--- |
| **Background** | `#1a1d36` | **Soft Midnight Indigo** — Velvet base for all windows. |
| **Foreground** | `#e0d4d4` | **Ash Pink** — Primary text and delicate details. |
| **Primary Accent** | `#00bfa5` | **Emerald** — Active workspaces, borders, and focus. |
| **Urgent/Secondary** | `#ff8fab` | **Soft Pink** — Warnings, muted states, and errors. |
| **Armor Layers** | `#090a14` | **Void Indigo** — Deep backgrounds for status bars and menus. |
| **UI Highlights** | `#2a2d46` | **Indigo Shadow** — Inactive borders and selection layers. |

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
