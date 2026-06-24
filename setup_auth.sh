#!/bin/bash
# =============================================================
# 🚀 PayEase - Smart Auto-Setup Script
# Works on: Mac, Linux, Windows (Git Bash/WSL)
# Usage: bash setup.sh
# =============================================================

set -e

# ─── Colors ───
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ─── Helpers ───
print_header() {
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}  $1"
    echo -e "${BLUE}╚══════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_step() { echo -e "${CYAN}▶ $1${NC}"; }
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }

# ─── Detect OS ───
OS_TYPE="unknown"
case "$(uname -s)" in
    Linux*)     OS_TYPE="linux";;
    Darwin*)    OS_TYPE="mac";;
    MINGW*|CYGWIN*|MSYS*) OS_TYPE="windows";;
esac

# =============================================================
# 🎬 START
# =============================================================

clear
echo ""
echo -e "${BLUE}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}                                                  ${BLUE}║${NC}"
echo -e "${BLUE}║${NC}    🚀 ${GREEN}PayEase Auto-Setup${NC} 💳                    ${BLUE}║${NC}"
echo -e "${BLUE}║${NC}    ${YELLOW}Detected OS: ${OS_TYPE}${NC}                          ${BLUE}║${NC}"
echo -e "${BLUE}║${NC}                                                  ${BLUE}║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════╝${NC}"
echo ""

# =============================================================
# 📦 Step 1: Check & Install Flutter
# =============================================================

print_header "📦 Step 1: Checking Flutter Installation"

if ! command -v flutter &> /dev/null; then
    print_warning "Flutter not found. Installing..."
    
    # Install location
    FLUTTER_DIR="$HOME/flutter"
    
    print_step "Cloning Flutter SDK (this may take 2-3 minutes)..."
    git clone --depth 1 -b stable https://github.com/flutter/flutter.git "$FLUTTER_DIR"
    
    # Add to PATH based on OS
    if [ "$OS_TYPE" = "windows" ]; then
        # Windows (Git Bash)
        echo "export PATH=\"\$PATH:$FLUTTER_DIR/bin\"" >> ~/.bashrc
        export PATH="$PATH:$FLUTTER_DIR/bin"
    elif [ "$OS_TYPE" = "mac" ]; then
        # Mac
        SHELL_RC="$HOME/.zshrc"
        [ -f "$HOME/.bash_profile" ] && SHELL_RC="$HOME/.bash_profile"
        echo "export PATH=\"\$PATH:$FLUTTER_DIR/bin\"" >> "$SHELL_RC"
        export PATH="$PATH:$FLUTTER_DIR/bin"
    else
        # Linux
        echo "export PATH=\"\$PATH:$FLUTTER_DIR/bin\"" >> ~/.bashrc
        export PATH="$PATH:$FLUTTER_DIR/bin"
    fi
    
    print_success "Flutter installed at $FLUTTER_DIR"
else
    print_success "Flutter already installed!"
    flutter --version | head -1
fi

# =============================================================
# 🌐 Step 2: Configure Flutter
# =============================================================

print_header "🌐 Step 2: Configuring Flutter"

print_step "Enabling Flutter Web..."
flutter config --enable-web > /dev/null 2>&1
flutter config --no-analytics > /dev/null 2>&1
dart --disable-analytics > /dev/null 2>&1
print_success "Flutter Web enabled!"

# =============================================================
# 🔧 Step 3: Git Safe Directory
# =============================================================

print_header "🔧 Step 3: Configuring Git"
git config --global --add safe.directory "$(pwd)" 2>/dev/null || true
git config --global --add safe.directory '*' 2>/dev/null || true
print_success "Git configured!"

# =============================================================
# 📦 Step 4: Install Dependencies
# =============================================================

print_header "📦 Step 4: Installing Project Dependencies"

if [ ! -f "pubspec.yaml" ]; then
    print_error "No pubspec.yaml found! Are you in the project root?"
    exit 1
fi

print_step "Running flutter pub get..."
flutter pub get
print_success "Dependencies installed!"

# =============================================================
# 🩺 Step 5: Verify Setup
# =============================================================

print_header "🩺 Step 5: Verifying Setup"
flutter doctor

# =============================================================
# 🎉 Done!
# =============================================================

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}                                                  ${GREEN}║${NC}"
echo -e "${GREEN}║${NC}    ✅ ${GREEN}PayEase Setup Complete!${NC} 🎉                ${GREEN}║${NC}"
echo -e "${GREEN}║${NC}                                                  ${GREEN}║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${CYAN}🚀 Run the app:${NC}"
echo -e "   ${GREEN}flutter run -d chrome${NC}"
echo ""
echo -e "${CYAN}🌐 Or web server (Codespaces/Gitpod):${NC}"
echo -e "   ${GREEN}flutter run -d web-server --web-hostname=0.0.0.0 --web-port=3000${NC}"
echo ""
echo -e "${CYAN}🔑 Demo Login:${NC}"
echo -e "   Mobile: ${YELLOW}9876543210${NC}"
echo -e "   OTP:    ${YELLOW}123456${NC}"
echo ""

# =============================================================
# 🎯 Auto-Run (Optional)
# =============================================================

read -p "$(echo -e ${YELLOW}Run app now? [Y/n]: ${NC})" -n 1 -r AUTORUN
echo
if [[ ! "$AUTORUN" =~ ^[Nn]$ ]]; then
    print_step "Starting PayEase..."
    flutter run -d chrome
fi