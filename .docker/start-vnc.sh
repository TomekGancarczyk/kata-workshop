#!/bin/bash
set -e

RESOLUTION=${RESOLUTION:-800x600}
VNC_PORT=5901
NOVNC_PORT=6080

echo "Starting Chocolate Doom with VNC..."
echo "Resolution: $RESOLUTION"

# Create VNC config directory
mkdir -p ~/.vnc

# Start TigerVNC server with built-in X server on display :1
# This creates both the X display and VNC server in one process
Xtigervnc :1 -geometry ${RESOLUTION} -depth 24 -rfbport $VNC_PORT -SecurityTypes None -AlwaysShared &
sleep 2

export DISPLAY=:1

# Start noVNC websocket proxy (web interface)
websockify --web=/usr/share/novnc $NOVNC_PORT localhost:$VNC_PORT &
sleep 1

echo ""
echo "============================================"
echo "  Doom is ready!"
echo "  Open http://localhost:$NOVNC_PORT/vnc.html in your browser"
echo "  Click 'Connect' to start playing"
echo "============================================"
echo ""

# Launch Doom with no sound (container has no audio device)
cd /app
exec ./chocolate-doom -iwad /app/wads/freedoom1.wad -window -nosound
