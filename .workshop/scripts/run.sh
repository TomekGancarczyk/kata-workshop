#!/bin/bash
# Run script for macOS and Linux

cd "$(dirname "$0")/../.."
./build/src/chocolate-doom -iwad .workshop/wads/freedoom1.wad "$@"
