# Docker Setup Guide

Run Chocolate Doom in your browser without installing any dependencies (except Docker).

**Works on:** Linux, macOS, Windows

**Time required:** 5 minutes (first build), instant after that

---

## Quick Start

```bash
cd .docker
docker compose up --build
```

Then open **http://localhost:6080/vnc.html** in your browser and click **Connect**.

That's it! You should see the Doom title screen!

---

## Game Controls

- **Arrow Keys** or **WASD**: Move
- **Ctrl**: Fire weapon
- **Space**: Use/Open doors
- **Shift**: Run (hold while moving)
- **1-7**: Select weapon
- **ESC**: Menu/Exit

---

## Stopping the Game

Press `Ctrl+C` in the terminal, or run (from the `.docker` directory):

```bash
docker compose down
```

---

## Configuration

### Change Resolution

Edit `.docker/docker-compose.yml`:

```yaml
environment:
  - RESOLUTION=1024x768
```

Then rebuild:

```bash
docker compose up --build
```

### Change Port

If port 6080 is already in use:

```yaml
ports:
  - "8080:6080"
```

Then access via http://localhost:8080/vnc.html

---

## Troubleshooting

### "Cannot connect to localhost:6080"

1. Make sure Docker is running
2. Check if the container started: `docker compose ps`
3. Check logs: `docker compose logs`

### Build fails

Make sure you're in the `.docker` directory:

```bash
cd .docker
docker compose up --build
```

### Game runs slowly

This is expected - the game runs through VNC in your browser, which adds ~50-200ms latency. It's playable but not as smooth as native.

### No sound

Sound is not supported in the Docker setup (VNC limitation). For full audio, use the native setup instead.

---

## Technical Details

The Docker setup uses:
- **TigerVNC (Xtigervnc)**: Combined X server + VNC server
- **noVNC + websockify**: Web-based VNC client via WebSocket

The game renders to the virtual X display inside the container, which is streamed to your browser via WebSocket.
