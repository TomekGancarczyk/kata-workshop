# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Info

This repository is a copy of the [Chocolate Doom](https://github.com/chocolate-doom/chocolate-doom) project, used for workshop purposes. It is hosted at `git@github.com:TomekGancarczyk/kata-workshop.git` and is not a fork—it's an independent copy.

## Project Overview

Chocolate Doom is a conservative Doom source port that aims to accurately reproduce the original DOS versions of Doom, Heretic, Hexen, and Strife. The project prioritizes vanilla compatibility, including intentionally preserving original bugs.

## Workshop Setup & Running the Game

There are two ways to set up and run the game:

### Option 1: Native Build (Recommended for Development)

**Setup (one-time):**
```bash
# macOS
brew install cmake sdl2 sdl2_mixer sdl2_net libpng libsamplerate

# Linux (Ubuntu/Debian)
sudo apt install build-essential cmake libsdl2-dev libsdl2-mixer-dev libsdl2-net-dev libpng-dev libsamplerate-dev
```

**Build & Run:**
```bash
./.workshop/scripts/build.sh    # Build (3-10 sec incremental)
./.workshop/scripts/run.sh      # Run the game
```

### Option 2: Docker (No Dependencies Required)

If you have Docker installed and don't want to install build tools:

```bash
cd .docker
docker compose up --build       # Build & run (opens in browser)
```

Then open **http://localhost:6080/vnc.html** and click Connect.

**Note:** Docker setup has no audio and ~50-200ms input latency. Use native build for best experience.

### Game Controls
- **Arrow Keys / WASD**: Move
- **Ctrl**: Fire weapon
- **Space**: Use/Open doors
- **ESC**: Menu/Exit

### Build Executables
- `chocolate-doom` - Doom port
- `chocolate-heretic` - Heretic port
- `chocolate-hexen` - Hexen port
- `chocolate-strife` - Strife port
- `chocolate-setup` - Configuration GUI
- `chocolate-server` - Dedicated multiplayer server

## Architecture

### Directory Structure
- `src/` - Main source code and shared game engine code
- `src/doom/`, `src/heretic/`, `src/hexen/`, `src/strife/` - Game-specific code
- `src/setup/` - Setup/configuration tool code
- `textscreen/` - Text-mode UI library (used by setup tool)
- `opl/` - OPL2/OPL3 FM synthesizer emulation for music
- `pcsound/` - PC speaker sound emulation

### Code Organization
The engine uses a subsystem prefix convention: `AM_` (automap), `G_` (game), `I_` (interface/system), `M_` (misc), `P_` (play/simulation), `R_` (rendering), `S_` (sound), `V_` (video), `W_` (WAD files), `Z_` (zone memory).

Game-specific libraries (`doom`, `heretic`, `hexen`, `strife`) are static libraries linked into their respective executables. Common code in `src/` is compiled into each executable.

### Key Dependencies
- SDL2 (≥2.0.14) - Required
- SDL2_mixer (≥2.0.2) - Audio mixing (optional, `--disable-sdl2mixer`)
- SDL2_net (≥2.0.0) - Networking (optional, `--disable-sdl2net`)
- libsamplerate - Audio resampling (optional)
- libpng - PNG screenshot support (optional)
- FluidSynth (≥2.2.0) - MIDI synthesis (optional)

## Code Style

- 4-space indentation, no tabs
- 80 column line limit
- Opening braces on their own line
- Always use braces for control statements
- C++ style comments (`//`)
- Function names: `AB_FunctionName` (prefix for subsystem, omit for static functions)
- Variable names: `snake_case`
- Type names: `lowercase_t` with subsystem prefix (e.g., `txt_window_t`)
- Pointer declarations: `char *ptr` (asterisk next to variable)

### Unsafe Functions - Use These Instead
| Avoid | Use |
|-------|-----|
| `sprintf`, `snprintf` | `M_snprintf()` |
| `strcpy`, `strncpy` | `M_StringCopy()` |
| `strcat`, `strncat` | `M_StringConcat()` |
| `strdup` | `M_StringDuplicate()` |
| `realloc` | `I_Realloc()` |

### Portability Wrappers
| C Function | Wrapper |
|------------|---------|
| `fopen` | `M_fopen()` |
| `remove` | `M_remove()` |
| `rename` | `M_rename()` |
| `stat` | `M_stat()` |
| `mkdir` | `M_MakeDirectory()` |
| `getenv` | `M_getenv()` |

### Portability Notes
- Use `int` or `int64_t` instead of `long`
- Use `SHORT()` and `LONG()` macros for endianness conversion
- Use SDL instead of platform-specific APIs where possible
