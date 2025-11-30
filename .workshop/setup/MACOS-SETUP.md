# macOS Setup Guide

This guide will help you set up Chocolate Doom for the AI-assisted coding workshop on **macOS**.

**Time required:** 15-30 minutes (one-time setup before workshop)

---

## Quick Setup Overview

1. Install Homebrew (if not installed)
2. Install build dependencies
3. Clone/download this repository
4. Make scripts executable
5. Build the project
6. Test that it works (game data is already included!)

---

## Step-by-Step Instructions

### 1. Install Homebrew (if not installed)

Open Terminal and run:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Build Dependencies

```bash
brew install cmake sdl2 sdl2_mixer sdl2_net libpng libsamplerate
```

### 3. Clone the Repository

```bash
git clone https://github.com/TomekGancarczyk/kata-workshop.git
cd kata-workshop
```

Or download and extract the workshop ZIP file, then:
```bash
cd kata-workshop
```

### 4. Make Scripts Executable

```bash
chmod +x .workshop/scripts/*.sh
```

### 5. Build the Project

```bash
./.workshop/scripts/build.sh
```

This takes 30-60 seconds on first build.

### 6. Game Data (Already Included!)

The WAD file is already included in the repository at `.workshop/wads/freedoom1.wad` - no download needed!

### 7. Test It Works

```bash
./.workshop/scripts/run.sh
```

You should see the game window open!

**Press ESC to exit the game.**

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

### "cannot be opened because the developer cannot be verified"
```bash
xattr -cr build/src/chocolate-doom
```

### SDL2 not found
```bash
brew link sdl2
```

### Build fails with missing headers
Make sure all dependencies are installed:
```bash
brew reinstall cmake sdl2 sdl2_mixer sdl2_net libpng libsamplerate
```

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
