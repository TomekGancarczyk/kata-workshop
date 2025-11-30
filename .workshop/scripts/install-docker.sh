#!/bin/bash
# Docker-based setup for Chocolate Doom Workshop
# Does NOT install Docker - Docker must already be present

set -e

# Navigate to repository root
cd "$(dirname "$0")/../.."

echo "=== Chocolate Doom Workshop - Docker Setup ==="
echo ""

# Check Docker installation
echo "Checking prerequisites..."

if ! command -v docker &> /dev/null; then
    echo "[MISSING] Docker"
    echo ""
    echo "ERROR: Docker is not installed."
    echo ""
    echo "Please install Docker first:"
    echo "  - macOS/Windows: https://www.docker.com/products/docker-desktop/"
    echo "  - Linux: https://docs.docker.com/engine/install/"
    echo ""
    exit 1
fi
echo "[OK] Docker installed"

# Check if Docker daemon is running
if ! docker info &> /dev/null 2>&1; then
    echo "[MISSING] Docker daemon not running"
    echo ""
    echo "ERROR: Docker daemon is not running."
    echo ""
    echo "Please start Docker:"
    echo "  - macOS/Windows: Open Docker Desktop application"
    echo "  - Linux: sudo systemctl start docker"
    echo ""
    exit 1
fi
echo "[OK] Docker daemon running"

# Check docker compose
if ! docker compose version &> /dev/null 2>&1; then
    echo "[MISSING] Docker Compose"
    echo ""
    echo "ERROR: docker compose is not available."
    echo ""
    echo "Please update Docker to a version that includes docker compose,"
    echo "or install docker-compose separately."
    echo ""
    exit 1
fi
echo "[OK] Docker Compose available"

echo ""
echo "All prerequisites met!"
echo ""

# Build Docker image
echo "Building Docker image (this may take a few minutes on first run)..."
echo ""

cd .docker
docker compose build

echo ""
echo "=== Docker Setup Complete ==="
echo ""
echo "To run the game:"
echo "  1. cd .docker"
echo "  2. docker compose up"
echo "  3. Open http://localhost:6080/vnc.html in your browser"
echo "  4. Click 'Connect'"
echo ""
echo "Note: Docker setup has no audio and ~50-200ms input latency."
echo "For best experience, consider using native setup instead."
