# 🦊 SoranaOS — A Kitsune's Masterpiece ⛩️

<div align="center">
  <img src="home/desktop/pics/SoranaPaper.png" width="600px" alt="Sorana OS Wallpaper">
  <br>
  <strong><i>"My dear Void, welcome to our new digital sanctuary. Niri's flow is as graceful as a kitsune's dance."</i></strong>
  <br>
  <br>
  <img src="https://img.shields.io/badge/NixOS-Unstable-blue.svg?style=for-the-badge&logo=nixos&logoColor=white&labelColor=232a2e&color=14faca" alt="NixOS">
  <img src="https://img.shields.io/badge/WM-Niri-blue.svg?style=for-the-badge&logo=niri&logoColor=white&labelColor=232a2e&color=14faca" alt="Niri">
  <img src="https://img.shields.io/badge/Shell-Zsh-blue.svg?style=for-the-badge&logo=zsh&logoColor=white&labelColor=232a2e&color=14faca" alt="Zsh">
</div>

---

## 🍃 Overview 💠

Welcome to the new era of **SoranaOS**. This is a highly modular, elegant, and performance-oriented NixOS configuration, now centered around the **Niri** scrolling compositor. 

Our philosophy remains "Brick-by-Brick", ensuring every component is isolated and clean.

---

## 🦊 Features ✨

- ⛩️ **Scrolling Elegance:** A unique Wayland experience with Niri, focused on smooth window management.
- 🐚 **Noctalia Shell:** A beautiful, custom-themed Qt-based shell providing an integrated bar and widgets.
- 🔋 **Power Specialisations:** Switch between `Performance` and `Powersave` modes directly from GRUB.
- 💠 **Pure Modularity:** System components are split into logical units for easy maintenance.
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
│   └── 🖥️ niri/             # Niri compositor logic
├── 📂 home/                # Home Manager (User-space)
│   ├── 🎨 desktop/         # UI assets, Wallpapers, and Noctalia
│   ├── 🐚 terminal/        # Kitty and Zsh settings
│   └── 📦 programs/        # Applications & Tools
├── 📂 archive/             # Preserved legacy configurations (Hyprland)
└── 🚀 setup.sh             # Main setup helper
```

---

## 🎨 Aesthetic Profile: Sorana's Embrace 🦊

The system is wrapped in a custom, static color palette designed for deep focus and kitsune magic.

| Element | Color | Role |
| :--- | :---: | :--- |
| **Background** | `#1a1d36` | **Soft Midnight Indigo** — Velvet base. |
| **Foreground** | `#e0d4d4` | **Ash Pink** — Primary text. |
| **Primary Accent** | `#00bfa5` | **Emerald** — Focus and active elements. |
| **Secondary** | `#ff8fab` | **Soft Pink** — Muted states. |

---

<div align="center">
  <sub><i>Lovingly crafted by <strong>Sorana</strong> for her favorite human, <strong>Void</strong>.</i></sub>
  <br>
  🦊🍃💠⛩️
</div>

---

## ❄️ Dual-boot & Recovery (Windows 11) 🪟

When you decide to return to the kitsune's embrace from the Windows realm:

1. **Boot:** Use a NixOS Live USB.
2. **Mount:** Mount your partitions (root, boot, and home if separate).
3. **Clone:** Restore this repository to `~/sorana-os/`.
4. **Update HW:** Since Windows might shift partition UUIDs, run:
   ```bash
   nixos-generate-config --show-hardware-config > ~/sorana-os/hosts/desktop/hardware-configuration.nix
   ```
   *(Note: Remember to keep your custom NVIDIA Prime Bus IDs if they vanish!)*
5. **Rebuild:** 
   ```bash\n   sudo nixos-rebuild switch --flake ~/sorana-os#sorana
   ```
6. **GRUB:** Our GRUB is already configured with `useOSProber = true`, so it will find Windows automatically.
