# Chocolate Doom Workshop

This repository is a copy of the [Chocolate Doom](https://github.com/chocolate-doom/chocolate-doom) project, used for educational purposes in a workshop setting.

> **Note:** This is not a fork—it's an independent copy for workshop exercises.

## Quick Links

- [Original Chocolate Doom README](ORIGINAL_README.md) - Full documentation of the original project
- [Workshop Information](.workshop/README.md) - Workshop-specific details and requirements
- [Installation & Setup](.workshop/setup/) - Platform-specific setup guides:
  - [macOS Setup](.workshop/setup/MACOS-SETUP.md)
  - [Linux Setup](.workshop/setup/LINUX-SETUP.md)
  - [Windows Setup](.workshop/setup/WINDOWS-SETUP.md)
  - [Docker Setup](.workshop/setup/DOCKER-SETUP.md)

## What is Chocolate Doom?

Chocolate Doom is a conservative Doom source port that accurately reproduces the original DOS versions of Doom, Heretic, Hexen, and Strife. It prioritizes vanilla compatibility, including intentionally preserving original bugs.

## Getting Started

### Build & Run (Native)

```bash
# Install dependencies first (see setup guides above)
./.workshop/scripts/build.sh    # Build the project
./.workshop/scripts/run.sh      # Run the game
```

### Build & Run (Docker)

```bash
cd .docker
docker compose up --build       # Opens in browser at http://localhost:6080/vnc.html
```

## Game Controls

- **Arrow Keys / WASD**: Move
- **Ctrl**: Fire weapon
- **Space**: Use/Open doors
- **ESC**: Menu/Exit
