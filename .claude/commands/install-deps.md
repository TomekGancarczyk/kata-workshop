# Install Workshop Dependencies

You are helping a user install dependencies for the Chocolate Doom workshop. Follow these steps carefully.

## Step 1: Detect Operating System

Run this command to detect the OS:

```bash
uname -s 2>/dev/null || echo "Windows"
```

Interpret the results:
- `Darwin` = macOS
- `Linux` = Linux (need to detect distro next)
- `MINGW64*` or `MSYS*` = Windows MSYS2
- If command fails = Windows (suggest MSYS2)

For Linux, also detect the distribution:
```bash
cat /etc/os-release 2>/dev/null | grep -E "^(ID|ID_LIKE|PRETTY_NAME)="
```

Also check for WSL (Windows Subsystem for Linux):
```bash
uname -r 2>/dev/null | grep -i microsoft
```
If this matches, treat as Linux.

Report the detected OS to the user.

## Step 2: Check Docker Availability

Run these commands to check if Docker is available:

```bash
docker --version 2>/dev/null && echo "Docker: Installed" || echo "Docker: Not installed"
```

```bash
docker info >/dev/null 2>&1 && echo "Docker daemon: Running" || echo "Docker daemon: Not running"
```

```bash
docker compose version 2>/dev/null && echo "Docker Compose: Available" || echo "Docker Compose: Not available"
```

Docker is fully available only if ALL three checks pass.

## Step 3: Ask User for Installation Method

**Only if Docker is fully available**, use the AskUserQuestion tool to ask:

**Question:** "Which installation method would you prefer?"

**Options:**
1. **Native Build** - Install build tools directly on your system (recommended for best performance, full audio support)
2. **Docker** - Run in container via browser (no local dependencies needed, but has ~50-200ms input latency and no audio)

**If Docker is NOT available**, inform the user:
- "Docker is not available on your system. Proceeding with Native installation."
- Skip to Step 4 with Native installation.

## Step 4: Run Installation Script

Based on OS and user choice, run the appropriate script:

### Native Installation

**macOS:**
```bash
./.workshop/scripts/install-native-macos.sh
```

**Linux:**
```bash
./.workshop/scripts/install-native-linux.sh
```

**Windows (MSYS2):**
```bash
./.workshop/scripts/install-native-windows.sh
```

### Docker Installation

For all platforms:
```bash
./.workshop/scripts/install-docker.sh
```

## Step 5: Verify Installation

### For Native Installation

Run the build script to verify:
```bash
./.workshop/scripts/build.sh
```

Check if build succeeded:
- Exit code 0 = success
- Check that `build/src/chocolate-doom` (or `.exe` on Windows) exists

### For Docker Installation

The `install-docker.sh` script already builds the Docker image.
Verify the image exists:
```bash
docker images | grep -E "(doom|kata)"
```

## Step 6: Report Results

### On Success - Native

Tell the user:
```
Setup complete!

To build (after code changes):
  ./.workshop/scripts/build.sh

To run the game:
  ./.workshop/scripts/run.sh

Game Controls:
- Arrow Keys / WASD: Move
- Ctrl: Fire
- Space: Use/Open doors
- ESC: Menu/Exit
```

### On Success - Docker

Tell the user:
```
Docker setup complete!

To run the game:
  1. cd .docker
  2. docker compose up
  3. Open http://localhost:6080/vnc.html
  4. Click "Connect"

Note: Docker has no audio and ~50-200ms input latency.

Game Controls:
- Arrow Keys / WASD: Move
- Ctrl: Fire
- Space: Use/Open doors
- ESC: Menu/Exit
```

### On Failure

If installation or build fails:
1. Show the error output to the user
2. Point them to the relevant setup guide:
   - macOS: `.workshop/setup/MACOS-SETUP.md`
   - Linux: `.workshop/setup/LINUX-SETUP.md`
   - Windows: `.workshop/setup/WINDOWS-SETUP.md`
   - Docker: `.workshop/setup/DOCKER-SETUP.md`
3. Offer to help troubleshoot the specific error

## Edge Cases

- **Homebrew not installed (macOS)**: The script will offer to install it
- **Wrong MSYS2 terminal (Windows)**: Script warns if not in MINGW64
- **All dependencies already installed**: Script reports this and skips installation
- **Partial installation**: Script only installs missing packages
- **Docker daemon not running**: Script provides instructions to start it
