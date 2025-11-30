# Linux Setup Guide

This guide will help you set up Chocolate Doom for the AI-assisted coding workshop on **Linux**.

**Time required:** 15-30 minutes (one-time setup before workshop)

---

## Quick Setup Overview

1. Install build dependencies for your distribution
2. Clone/download this repository
3. Make scripts executable
4. Build the project
5. Test that it works (game data is already included!)

---

## Ubuntu/Debian

### 1. Install Build Dependencies

```bash
sudo apt update
sudo apt install -y \
    build-essential \
    cmake \
    libsdl2-dev \
    libsdl2-mixer-dev \
    libsdl2-net-dev \
    libpng-dev \
    libsamplerate-dev \
    git
```

### 2. Clone Repository

```bash
git clone https://github.com/TomekGancarczyk/kata-workshop.git
cd kata-workshop
```

### 3. Make Scripts Executable

```bash
chmod +x .workshop/scripts/*.sh
```

### 4. Build

```bash
./.workshop/scripts/build.sh
```

### 5. Game Data (Already Included!)

The WAD file is already included in the repository at `.workshop/wads/freedoom1.wad` - no download needed!

### 6. Test

```bash
./.workshop/scripts/run.sh
```

---

## Fedora/RHEL/CentOS

### 1. Install Dependencies

```bash
sudo dnf install -y \
    gcc \
    cmake \
    SDL2-devel \
    SDL2_mixer-devel \
    SDL2_net-devel \
    libpng-devel \
    libsamplerate-devel \
    git
```

### 2. Clone Repository

```bash
git clone https://github.com/TomekGancarczyk/kata-workshop.git
cd kata-workshop
```

### 3. Make Scripts Executable

```bash
chmod +x .workshop/scripts/*.sh
```

### 4. Build

```bash
./.workshop/scripts/build.sh
```

### 5. Game Data (Already Included!)

The WAD file is already included in the repository at `.workshop/wads/freedoom1.wad` - no download needed!

### 6. Test

```bash
./.workshop/scripts/run.sh
```

---

## Arch Linux

### 1. Install Dependencies

```bash
sudo pacman -S base-devel cmake sdl2 sdl2_mixer sdl2_net libpng libsamplerate git
```

### 2. Clone Repository

```bash
git clone https://github.com/TomekGancarczyk/kata-workshop.git
cd kata-workshop
```

### 3. Make Scripts Executable

```bash
chmod +x .workshop/scripts/*.sh
```

### 4. Build

```bash
./.workshop/scripts/build.sh
```

### 5. Game Data (Already Included!)

The WAD file is already included in the repository at `.workshop/wads/freedoom1.wad` - no download needed!

### 6. Test

```bash
./.workshop/scripts/run.sh
```

---

## Workshop Quick Reference

Once setup is complete, during the workshop you'll use these commands:

### Quick Rebuild (after code changes)
```bash
./.workshop/scripts/build.sh
```
**Takes 3-10 seconds for incremental builds!**

### Run the Game
```bash
./.workshop/scripts/run.sh
```

### Game Controls
- **Arrow Keys** or **WASD**: Move
- **Ctrl**: Fire weapon
- **Space**: Use/Open doors
- **Shift**: Run (hold while moving)
- **1-7**: Select weapon
- **ESC**: Menu/Exit

---

## Troubleshooting

### SDL2 not found
```bash
# Ubuntu/Debian:
sudo apt install libsdl2-2.0-0 libsdl2-mixer-2.0-0 libsdl2-net-2.0-0

# Fedora:
sudo dnf install SDL2 SDL2_mixer SDL2_net
```

### Game crashes on startup
- Make sure you have OpenGL/graphics drivers installed
- Try running with `-window` flag for windowed mode:
```bash
./build/src/chocolate-doom -iwad .workshop/wads/freedoom1.wad -window
```

### Build fails with missing headers
Make sure all development packages are installed (packages ending in `-dev` or `-devel`).

---

## Pre-Workshop Checklist

Before the workshop starts, verify:

- [ ] Repository cloned/downloaded
- [ ] Project builds successfully
- [ ] Game launches and you see the title screen
- [ ] You can move around in the game
- [ ] You have a text editor ready (VS Code recommended)
- [ ] You know where the code files are located (`src/doom/` directory)

---

## Alternative: Dev Container (Optional)

If you use VS Code and prefer containers:

1. Install Docker
2. Install "Dev Containers" extension in VS Code
3. Open this folder in VS Code
4. Press F1 → "Dev Containers: Reopen in Container"

---

## What You'll Need During Workshop

- This repository (already set up)
- Text editor (VS Code, Sublime, vim, etc.)
- Terminal
- Your AI assistant tool (Claude Code, Copilot, etc.)

---

## Getting Help

If you have issues during setup:

1. Check the troubleshooting section above
2. Search for your error message online
3. Contact the workshop organizer
4. Join early for setup help before the workshop
