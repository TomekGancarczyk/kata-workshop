#!/bin/bash
# Native dependency installation for Linux
# Auto-detects distro, checks each package before installing

set -e

# Navigate to repository root
cd "$(dirname "$0")/../.."

echo "=== Chocolate Doom Workshop - Linux Native Setup ==="
echo ""

# Detect distribution
detect_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian|linuxmint|pop|elementary|zorin)
                echo "debian"
                ;;
            fedora|rhel|centos|rocky|alma|nobara)
                echo "fedora"
                ;;
            arch|manjaro|endeavouros|garuda)
                echo "arch"
                ;;
            opensuse*)
                echo "opensuse"
                ;;
            *)
                # Check ID_LIKE for derivatives
                case "$ID_LIKE" in
                    *debian*|*ubuntu*)
                        echo "debian"
                        ;;
                    *fedora*|*rhel*)
                        echo "fedora"
                        ;;
                    *arch*)
                        echo "arch"
                        ;;
                    *suse*)
                        echo "opensuse"
                        ;;
                    *)
                        echo "unknown"
                        ;;
                esac
                ;;
        esac
    else
        echo "unknown"
    fi
}

# Check functions for each distro
check_apt_package() {
    dpkg -l "$1" 2>/dev/null | grep -q "^ii"
}

check_dnf_package() {
    rpm -q "$1" &>/dev/null
}

check_pacman_package() {
    pacman -Q "$1" &>/dev/null
}

check_zypper_package() {
    rpm -q "$1" &>/dev/null
}

# Detect distro
DISTRO=$(detect_distro)
echo "Detected distribution family: $DISTRO"

if [[ "$DISTRO" == "unknown" ]]; then
    echo ""
    echo "ERROR: Unknown Linux distribution."
    echo "Please install dependencies manually. See .workshop/setup/LINUX-SETUP.md"
    exit 1
fi

echo ""
echo "Checking dependencies..."

# Arrays to track status
INSTALLED=()
MISSING=()

case "$DISTRO" in
    debian)
        PACKAGES=(build-essential cmake libsdl2-dev libsdl2-mixer-dev libsdl2-net-dev libpng-dev libsamplerate-dev git)
        CHECK_CMD="check_apt_package"
        INSTALL_CMD="sudo apt install -y"
        UPDATE_CMD="sudo apt update"
        ;;
    fedora)
        PACKAGES=(gcc cmake SDL2-devel SDL2_mixer-devel SDL2_net-devel libpng-devel libsamplerate-devel git)
        CHECK_CMD="check_dnf_package"
        INSTALL_CMD="sudo dnf install -y"
        UPDATE_CMD=""
        ;;
    arch)
        PACKAGES=(base-devel cmake sdl2 sdl2_mixer sdl2_net libpng libsamplerate git)
        CHECK_CMD="check_pacman_package"
        INSTALL_CMD="sudo pacman -S --needed --noconfirm"
        UPDATE_CMD=""
        ;;
    opensuse)
        PACKAGES=(gcc cmake libSDL2-devel libSDL2_mixer-devel libSDL2_net-devel libpng16-devel libsamplerate-devel git)
        CHECK_CMD="check_zypper_package"
        INSTALL_CMD="sudo zypper install -y"
        UPDATE_CMD=""
        ;;
esac

# Check each package
for pkg in "${PACKAGES[@]}"; do
    if $CHECK_CMD "$pkg"; then
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
    echo "Note: You may be prompted for your sudo password."
    echo ""

    # Run update if needed (for apt)
    if [[ -n "$UPDATE_CMD" ]]; then
        $UPDATE_CMD
    fi

    $INSTALL_CMD "${MISSING[@]}"
fi

# Make scripts executable
echo ""
echo "Making scripts executable..."
chmod +x .workshop/scripts/*.sh 2>/dev/null || true

echo ""
echo "=== Linux Native Setup Complete ==="
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
