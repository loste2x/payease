#!/bin/bash
# =============================================
# 🚀 PayEase - Post-Create Setup Script
# =============================================

set -e

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║   🚀 PayEase - Flutter Setup Starting...    ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# ── Step 1: Verify Flutter ──
echo "📦 Step 1: Verifying Flutter installation..."
flutter --version
echo "✅ Flutter verified!"
echo ""

# ── Step 2: Enable Flutter Web ──
echo "🌐 Step 2: Enabling Flutter Web..."
flutter config --enable-web
echo "✅ Flutter Web enabled!"
echo ""

# ── Step 3: Add git safe directory ──
echo "🔧 Step 3: Configuring Git..."
git config --global --add safe.directory /usr/local/flutter
git config --global --add safe.directory /workspaces/payease
echo "✅ Git configured!"
echo ""

# ── Step 4: Check if Flutter project exists ──
if [ -f "pubspec.yaml" ]; then
    echo "📂 Step 4: Flutter project found! Running pub get..."
    flutter pub get
    echo "✅ Dependencies installed!"
else
    echo "📂 Step 4: No Flutter project found."
    echo "   ➡️  Run this to create PayEase project:"
    echo "   flutter create --project-name payease_app --org com.payease ."
    echo ""
fi

# ── Step 5: Flutter Doctor ──
echo ""
echo "🩺 Step 5: Running Flutter Doctor..."
flutter doctor
echo ""

# ── Done ──
echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║   ✅ PayEase Setup Complete!                ║"
echo "║                                              ║"
echo "║   🌐 Run Web App:                           ║"
echo "║   flutter run -d web-server \               ║"
echo "║     --web-hostname=0.0.0.0 \                ║"
echo "║     --web-port=3000                          ║"
echo "║                                              ║"
echo "║   🔥 Happy Coding with PayEase!             ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
