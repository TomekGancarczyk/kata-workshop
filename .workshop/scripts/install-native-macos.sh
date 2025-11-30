#!/bin/bash
# Native dependency installation for macOS
# Checks each package before installing, only installs missing ones

set -e

# Navigate to repository root
cd "$(dirname "$0")/../.."

echo "=== Chocolate Doom Workshop - macOS Native Setup ==="
echo ""

# Package list
PACKAGES=(cmake sdl2 sdl2_mixer sdl2_net libpng libsamplerate)

# Check if a brew package is installed
check_brew_package() {
    brew list --formula 2>/dev/null | grep -q "^$1$"
}

# Arrays to track status
INSTALLED=()
MISSING=()

# Check for Homebrew first
echo "Checking prerequisites..."
if ! command -v brew &> /dev/null; then
    echo "[MISSING] Homebrew"
    echo ""
    echo "Homebrew is required but not installed."
    echo "Install it with:"
    echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    echo ""
    read -p "Would you like to install Homebrew now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Add brew to PATH for Apple Silicon
        if [[ -f /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        echo "Cannot proceed without Homebrew. Exiting."
        exit 1
    fi
else
    echo "[OK] Homebrew"
fi

echo ""
echo "Checking dependencies..."

# Check each package
for pkg in "${PACKAGES[@]}"; do
    if check_brew_package "$pkg"; then
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
    echo "Installing ${#MISSING[@]} missing package(s): ${MISSING[*]}"
    echo ""
    brew install "${MISSING[@]}"
fi

# Make scripts executable
echo ""
echo "Making scripts executable..."
chmod +x .workshop/scripts/*.sh 2>/dev/null || true

echo ""
echo "=== macOS Native Setup Complete ==="
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
