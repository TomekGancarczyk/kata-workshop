#!/bin/bash
# Build script for macOS, Linux, and Windows (MSYS2)

cd "$(dirname "$0")/../.."
cmake -B build -S .
cmake --build build -j4
