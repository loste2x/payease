# =============================================================
# 🐳 PayEase - Flutter Development Container (v3.0)
# Bill Payment & Wallet App with Cashback Engine
# =============================================================
# Stack: Flutter 3.x + Dart 3.x + Material 3
# Phases: Auth + Home Dashboard + Wallet + Bills + Cashback
# Base: Ubuntu 22.04 (LTS)
# =============================================================

FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# =============================================================
# 🏷️  Metadata
# =============================================================
LABEL maintainer="PayEase Team"
LABEL description="Flutter dev container for PayEase fintech app"
LABEL version="3.0"

# =============================================================
# 🌍 Environment Variables
# =============================================================
ENV FLUTTER_SDK_VERSION="stable"
ENV FLUTTER_HOME="/usr/local/flutter"
ENV DART_HOME="${FLUTTER_HOME}/bin/cache/dart-sdk"
ENV PUB_CACHE="${FLUTTER_HOME}/.pub-cache"
ENV PATH="${PATH}:${FLUTTER_HOME}/bin:${DART_HOME}/bin:${PUB_CACHE}/bin"

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

# Locale settings (for currency formatting ₹)
ENV LANG=en_IN.UTF-8
ENV LC_ALL=en_IN.UTF-8

# =============================================================
# 📦 Install System Dependencies
# =============================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Core utilities
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    wget \
    ca-certificates \
    gnupg \
    lsb-release \
    locales \
    sudo \
    # Build tools
    cmake \
    ninja-build \
    clang \
    pkg-config \
    make \
    # Flutter required libs
    libglu1-mesa \
    libgtk-3-dev \
    liblzma-dev \
    libstdc++-12-dev \
    # Web testing
    chromium-browser \
    chromium-chromedriver \
    # Image processing (for assets)
    libjpeg-dev \
    libpng-dev \
    # Network tools
    net-tools \
    iputils-ping \
    # Modern shell tools
    zsh \
    htop \
    tree \
    jq \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# =============================================================
# 🌐 Generate Locale (for ₹ currency formatting)
# =============================================================
RUN locale-gen en_IN.UTF-8 && update-locale LANG=en_IN.UTF-8

# =============================================================
# 🌍 Configure Chrome for Flutter Web
# =============================================================
ENV CHROME_EXECUTABLE=/usr/bin/chromium-browser
ENV CHROMEDRIVER_BIN=/usr/bin/chromedriver

# Chrome flags for headless testing
ENV CHROME_FLAGS="--no-sandbox --disable-dev-shm-usage --disable-gpu --headless"

# =============================================================
# 🐦 Clone Flutter SDK (stable channel)
# =============================================================
RUN git clone https://github.com/flutter/flutter.git \
    --branch ${FLUTTER_SDK_VERSION} \
    --depth 1 \
    ${FLUTTER_HOME} \
    && git config --global --add safe.directory ${FLUTTER_HOME} \
    && git config --global --add safe.directory '*'

# =============================================================
# 🚀 Pre-configure Flutter (faster first-time setup)
# =============================================================
RUN flutter precache --web \
    && flutter config --enable-web \
    && flutter config --no-analytics \
    && dart --disable-analytics

# =============================================================
# 📦 Pre-cache Common Packages (for PayEase)
# =============================================================
RUN mkdir -p /tmp/flutter_cache_setup \
    && cd /tmp/flutter_cache_setup \
    && flutter create --project-name temp_cache --org com.temp . > /dev/null 2>&1 \
    && flutter pub add \
        flutter_bloc \
        equatable \
        get_it \
        go_router \
        pin_code_fields \
        intl \
        dio \
        flutter_secure_storage \
        shared_preferences \
        cached_network_image \
        > /dev/null 2>&1 \
    && flutter pub get > /dev/null 2>&1 \
    && cd / \
    && rm -rf /tmp/flutter_cache_setup

# =============================================================
# 🩺 Verify Flutter Setup
# =============================================================
RUN flutter doctor -v

# =============================================================
# 👤 Set Ownership for vscode User
# =============================================================
RUN chown -R vscode:vscode ${FLUTTER_HOME} \
    && chown -R vscode:vscode ${PUB_CACHE}

# =============================================================
# 🐚 Setup Zsh for Better Terminal Experience
# =============================================================
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
    && chsh -s $(which zsh) vscode 2>/dev/null || true

# =============================================================
# 📝 Add Flutter PATH to bashrc and zshrc
# =============================================================
RUN echo 'export FLUTTER_HOME=/usr/local/flutter' >> /home/vscode/.bashrc \
    && echo 'export PATH="$PATH:$FLUTTER_HOME/bin:$FLUTTER_HOME/bin/cache/dart-sdk/bin:$FLUTTER_HOME/.pub-cache/bin"' >> /home/vscode/.bashrc \
    && echo 'export CHROME_EXECUTABLE=/usr/bin/chromium-browser' >> /home/vscode/.bashrc \
    && echo 'export FLUTTER_HOME=/usr/local/flutter' >> /home/vscode/.zshrc \
    && echo 'export PATH="$PATH:$FLUTTER_HOME/bin:$FLUTTER_HOME/bin/cache/dart-sdk/bin:$FLUTTER_HOME/.pub-cache/bin"' >> /home/vscode/.zshrc \
    && echo 'export CHROME_EXECUTABLE=/usr/bin/chromium-browser' >> /home/vscode/.zshrc

# =============================================================
# 🎨 Add Helpful Aliases for PayEase Development
# =============================================================
RUN cat >> /home/vscode/.bashrc << 'EOF'

# ═══════════════════════════════════════════════
# 🚀 PayEase Development Aliases
# ═══════════════════════════════════════════════
alias pe-run='flutter run -d web-server --web-hostname=0.0.0.0 --web-port=3000'
alias pe-build='flutter build web'
alias pe-clean='flutter clean && flutter pub get'
alias pe-check='flutter analyze'
alias pe-test='flutter test'
alias pe-doctor='flutter doctor -v'
alias pe-upgrade='flutter pub upgrade'
alias pe-outdated='flutter pub outdated'

# Git shortcuts
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'

# Welcome message
echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║   🚀 PayEase Dev Container Ready! 💳        ║"
echo "║   Payments Made Easy!                        ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
echo "📋 Quick Commands:"
echo "  pe-run     → Run web app on port 3000"
echo "  pe-build   → Build production web"
echo "  pe-check   → Run flutter analyze"
echo "  pe-clean   → Clean & reinstall deps"
echo "  pe-doctor  → Run flutter doctor"
echo ""
echo "🔑 Demo OTP: 123456"
echo ""
EOF

# Copy bashrc to zshrc
RUN cp /home/vscode/.bashrc /home/vscode/.zshrc.payease \
    && cat /home/vscode/.zshrc.payease >> /home/vscode/.zshrc \
    && rm /home/vscode/.zshrc.payease \
    && chown vscode:vscode /home/vscode/.bashrc /home/vscode/.zshrc

# =============================================================
# 🔐 Allow vscode user to use sudo without password
# =============================================================
RUN echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode

# =============================================================
# 📂 Set Working Directory
# =============================================================
WORKDIR /workspaces

# =============================================================
# 👤 Switch to vscode user
# =============================================================
USER vscode

# =============================================================
# 🩺 Healthcheck
# =============================================================
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD flutter --version || exit 1

# =============================================================
# 🎯 Default Command
# =============================================================
CMD ["sleep", "infinity"]