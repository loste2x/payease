# =============================================
# 🐳 PayEase - Flutter Development Container
# =============================================

FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Set environment variables
ENV FLUTTER_SDK_VERSION="stable"
ENV FLUTTER_HOME="/usr/local/flutter"
ENV DART_HOME="${FLUTTER_HOME}/bin/cache/dart-sdk"
ENV PATH="${PATH}:${FLUTTER_HOME}/bin:${DART_HOME}/bin:${FLUTTER_HOME}/.pub-cache/bin"

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    wget \
    ca-certificates \
    gnupg \
    lsb-release \
    cmake \
    ninja-build \
    clang \
    pkg-config \
    libgtk-3-dev \
    liblzma-dev \
    libstdc++-12-dev \
    chromium-browser \
    && rm -rf /var/lib/apt/lists/*

# Set Chrome executable for Flutter Web testing
ENV CHROME_EXECUTABLE=/usr/bin/chromium-browser

# Clone Flutter SDK (stable channel)
RUN git clone https://github.com/flutter/flutter.git -b ${FLUTTER_SDK_VERSION} ${FLUTTER_HOME} \
    && git config --global --add safe.directory ${FLUTTER_HOME}

# Pre-download Flutter dependencies & enable web
RUN flutter precache \
    && flutter config --enable-web \
    && flutter config --no-analytics \
    && dart --disable-analytics

# Run flutter doctor to verify setup
RUN flutter doctor -v

# Set ownership for vscode user
RUN chown -R vscode:vscode ${FLUTTER_HOME}

# Set working directory
WORKDIR /workspaces
