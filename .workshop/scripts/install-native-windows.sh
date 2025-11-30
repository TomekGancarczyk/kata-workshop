#!/bin/bash
# Native dependency installation for Windows (MSYS2/MINGW64)
# Checks each package before installing

set -e

# Navigate to repository root
cd "$(dirname "$0")/../.."

echo "=== Chocolate Doom Workshop - Windows MSYS2 Setup ==="
echo ""

# Check if running in MSYS2
if [[ -z "$MSYSTEM" ]]; then
    echo "ERROR: Not running in MSYS2 environment."
    echo ""
    echo "Please run this script from MSYS2 MINGW64 terminal (blue icon)."
    echo "Download MSYS2 from: https://www.msys2.org/"
    exit 1
fi

# Warn if not MINGW64
if [[ "$MSYSTEM" != "MINGW64" ]]; then
    echo "WARNING: You are running in $MSYSTEM environment."
    echo "For best results, use MSYS2 MINGW64 terminal (blue icon)."
    echo ""
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    echo "Environment: MSYS2 MINGW64"
fi

echo ""
echo "Checking dependencies..."

# Package list
PACKAGES=(
    mingw-w64-x86_64-gcc
    mingw-w64-x86_64-cmake
    mingw-w64-x86_64-SDL2
    mingw-w64-x86_64-SDL2_mixer
    mingw-w64-x86_64-SDL2_net
    mingw-w64-x86_64-libpng
    mingw-w64-x86_64-libsamplerate
    make
    git
)

# Check if a pacman package is installed
check_pacman_package() {
    pacman -Q "$1" &>/dev/null
}

# Arrays to track status
INSTALLED=()
MISSING=()

# Check each package
for pkg in "${PACKAGES[@]}"; do
    if check_pacman_package "$pkg"; then
        echo "[OK] $pkg"
        INSTALLED+=("$pkg")
    else
        echo "[MISSING] $pkg"
        MISSING+=("$pkg")
    fi
done

echo ""

# Install missing packages if any
if [ ${#MISSING[@]} -eq 0 ]; then
    echo "All dependencies are already installed!"
else
    echo "Installing ${#MISSING[@]} missing package(s)..."
    echo ""

    # Update package database first
    echo "Updating package database..."
    pacman -Sy --noconfirm

    # Install missing packages
    pacman -S --needed --noconfirm "${MISSING[@]}"
fi

# Make scripts executable
echo ""
echo "Making scripts executable..."
chmod +x .workshop/scripts/*.sh 2>/dev/null || true

echo ""
echo "=== Windows MSYS2 Setup Complete ==="
echo ""
if [ ${#MISSING[@]} -gt 0 ]; then
    echo "Installed: ${MISSING[*]}"
fi
if [ ${#INSTALLED[@]} -gt 0 ]; then
    echo "Already present: ${INSTALLED[*]}"
fi
echo ""
echo "Next steps:"
echo "  1. Build:  ./.workshop/scripts/build.sh"
echo "  2. Run:    ./.workshop/scripts/run.sh"
echo "         or: .workshop\\scripts\\run.bat (from cmd.exe)"
