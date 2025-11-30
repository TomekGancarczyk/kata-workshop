# Windows Setup Guide

This guide will help you set up Chocolate Doom for the AI-assisted coding workshop on **Windows**.

**Time required:** 15-30 minutes (one-time setup before workshop)

---

## Quick Setup Overview

1. Install MSYS2
2. Update package database
3. Install build dependencies
4. Clone/download this repository
5. Build the project
6. Test that it works (game data is already included!)

---

## Step-by-Step Instructions

### 1. Install MSYS2

1. Download MSYS2 installer from: https://www.msys2.org/
2. Run the installer (default location: `C:\msys64`)
3. Open **MSYS2 MINGW64** terminal (blue icon)

### 2. Update Package Database

In MSYS2 terminal:
```bash
pacman -Syu
```

Close and reopen MSYS2 terminal, then:
```bash
pacman -Su
```

### 3. Install Build Dependencies

```bash
pacman -S mingw-w64-x86_64-gcc \
          mingw-w64-x86_64-cmake \
          mingw-w64-x86_64-SDL2 \
          mingw-w64-x86_64-SDL2_mixer \
          mingw-w64-x86_64-SDL2_net \
          mingw-w64-x86_64-libpng \
          mingw-w64-x86_64-libsamplerate \
          make \
          git
```

### 4. Clone the Repository

In MSYS2 terminal:
```bash
cd ~
git clone https://github.com/TomekGancarczyk/kata-workshop.git
cd kata-workshop
```

Or if you downloaded a ZIP:
```bash
cd /c/Users/YourUsername/Downloads/kata-workshop
```

### 5. Make Scripts Executable (MSYS2 only)

```bash
chmod +x .workshop/scripts/*.sh
```

### 6. Build the Project

```bash
./.workshop/scripts/build.sh
```

This takes 30-60 seconds on first build.

### 7. Game Data (Already Included!)

The WAD file is already included in the repository at `.workshop/wads/freedoom1.wad` - no download needed!

### 8. Test It Works

```bash
# Using the run script (MSYS2):
./.workshop/scripts/run.sh

# Or on Windows with cmd:
.workshop\scripts\run.bat
```

Game window should open!

**Press ESC to exit.**

---

## Alternative: Visual Studio Setup (Advanced)

If you prefer Visual Studio:

1. Install Visual Studio 2022 Community Edition
2. Install "Desktop development with C++" workload
3. Download SDL2 development libraries from https://libsdl.org/
4. Use CMake GUI to generate Visual Studio solution
5. Build in Visual Studio

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
# MSYS2:
./.workshop/scripts/run.sh

# Windows cmd:
.workshop\scripts\run.bat
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

### "SDL2.dll not found"
- Make sure you're using MSYS2 MINGW64 terminal (not MSYS2 MSYS)
- SDL2 should be in PATH automatically in MINGW64 environment

### "Permission denied" when running exe
```bash
chmod +x build/src/chocolate-doom.exe
```

### Build fails
Make sure you're in the MINGW64 terminal (blue icon), not the regular MSYS2 terminal.

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

## What You'll Need During Workshop

- This repository (already set up)
- Text editor (VS Code, Sublime, Notepad++, etc.)
- MSYS2 MINGW64 terminal or Windows command prompt
- Your AI assistant tool (Claude Code, Copilot, etc.)

---

## Getting Help

If you have issues during setup:

1. Check the troubleshooting section above
2. Search for your error message online
3. Contact the workshop organizer
4. Join early for setup help before the workshop
