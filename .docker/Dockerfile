FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install VNC stack + SDL2 runtime libraries + build dependencies
RUN apt-get update && apt-get install -y \
    # VNC/Display stack
    xvfb \
    tigervnc-standalone-server \
    novnc \
    websockify \
    # SDL2 runtime libraries
    libsdl2-2.0-0 \
    libsdl2-mixer-2.0-0 \
    libsdl2-net-2.0-0 \
    libpng16-16 \
    libsamplerate0 \
    # Build dependencies (will be removed after build)
    build-essential \
    cmake \
    libsdl2-dev \
    libsdl2-mixer-dev \
    libsdl2-net-dev \
    libpng-dev \
    libsamplerate-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy source code
COPY . /build
WORKDIR /build

# Build chocolate-doom
RUN cmake -B build -S . && cmake --build build -j$(nproc)

# Setup runtime directory
RUN mkdir -p /app && \
    cp build/src/chocolate-doom /app/ && \
    cp -r .workshop/wads /app/wads

# Copy startup script
COPY .docker/start-vnc.sh /app/start-vnc.sh
RUN chmod +x /app/start-vnc.sh

# Cleanup build dependencies to reduce image size
RUN apt-get purge -y \
    build-essential \
    cmake \
    libsdl2-dev \
    libsdl2-mixer-dev \
    libsdl2-net-dev \
    libpng-dev \
    libsamplerate-dev \
    && apt-get autoremove -y \
    && rm -rf /build

# noVNC web interface port
EXPOSE 6080

WORKDIR /app
CMD ["/app/start-vnc.sh"]
