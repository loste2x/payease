#!/bin/bash
# =============================================================
# 🚀 PayEase - Complete Setup Script (v3.0)
# Bill Payment & Wallet App with Cashback Engine
# =============================================================
# Phases: Core Setup + Auth Module + Home Dashboard
# Stack: Flutter + Material 3 + BLoC + Clean Architecture
# =============================================================

set -e

# Colors for better readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}   $1"
    echo -e "${BLUE}╚══════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_step() {
    echo -e "${CYAN}▶ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# =============================================================
# 🎬 START
# =============================================================

clear
echo ""
echo -e "${BLUE}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}                                                  ${BLUE}║${NC}"
echo -e "${BLUE}║${NC}     🚀 ${GREEN}PayEase Setup Starting...${NC} 💳            ${BLUE}║${NC}"
echo -e "${BLUE}║${NC}     ${YELLOW}Payments Made Easy!${NC}                       ${BLUE}║${NC}"
echo -e "${BLUE}║${NC}                                                  ${BLUE}║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════╝${NC}"
echo ""

# =============================================================
# 📦 STEP 1: Verify Flutter Installation
# =============================================================

print_header "📦 Step 1: Verifying Flutter Installation"
print_step "Checking Flutter version..."

if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed!"
    echo ""
    echo "Please install Flutter first:"
    echo "  git clone https://github.com/flutter/flutter.git -b stable ~/flutter"
    echo "  echo 'export PATH=\"\$PATH:\$HOME/flutter/bin\"' >> ~/.bashrc"
    echo "  source ~/.bashrc"
    exit 1
fi

flutter --version
print_success "Flutter verified!"

# =============================================================
# 🌐 STEP 2: Configure Flutter
# =============================================================

print_header "🌐 Step 2: Configuring Flutter"

print_step "Enabling Flutter Web..."
flutter config --enable-web > /dev/null 2>&1
print_success "Flutter Web enabled!"

print_step "Disabling analytics..."
flutter config --no-analytics > /dev/null 2>&1
dart --disable-analytics > /dev/null 2>&1
print_success "Analytics disabled!"

# =============================================================
# 🔧 STEP 3: Configure Git
# =============================================================

print_header "🔧 Step 3: Configuring Git"

print_step "Adding safe directories..."
git config --global --add safe.directory /usr/local/flutter 2>/dev/null || true
git config --global --add safe.directory ~/flutter 2>/dev/null || true
git config --global --add safe.directory "$(pwd)" 2>/dev/null || true
print_success "Git configured!"

# =============================================================
# 📂 STEP 4: Project Verification
# =============================================================

print_header "📂 Step 4: Checking Flutter Project"

if [ ! -f "pubspec.yaml" ]; then
    print_warning "No Flutter project found in current directory!"
    echo ""
    print_step "Creating PayEase Flutter project..."
    flutter create --project-name payease_app --org com.payease . > /dev/null
    print_success "PayEase project created!"
else
    print_success "Flutter project found!"
fi

# =============================================================
# 📦 STEP 5: Install Dependencies
# =============================================================

print_header "📦 Step 5: Installing Dependencies"

print_step "Adding required packages..."

# State Management
flutter pub add flutter_bloc equatable 2>/dev/null || true

# Dependency Injection
flutter pub add get_it 2>/dev/null || true

# Navigation
flutter pub add go_router 2>/dev/null || true

# UI / OTP
flutter pub add pin_code_fields 2>/dev/null || true

# Utils
flutter pub add intl 2>/dev/null || true

print_step "Running pub get..."
flutter pub get
print_success "All dependencies installed!"

# =============================================================
# 📁 STEP 6: Creating Folder Structure
# =============================================================

print_header "📁 Step 6: Creating Project Folder Structure"

# ─── Config ───
print_step "Creating config folders..."
mkdir -p lib/config/env
mkdir -p lib/config/routes
mkdir -p lib/config/flavors

# ─── Core ───
print_step "Creating core folders..."
mkdir -p lib/core/constants
mkdir -p lib/core/errors
mkdir -p lib/core/network
mkdir -p lib/core/theme
mkdir -p lib/core/utils
mkdir -p lib/core/widgets
mkdir -p lib/core/usecase
mkdir -p lib/core/extensions

# ─── Feature: Auth (Phase 2) ───
print_step "Creating auth module..."
mkdir -p lib/features/auth/data/{datasources,models,repositories}
mkdir -p lib/features/auth/domain/{entities,repositories,usecases}
mkdir -p lib/features/auth/presentation/{bloc,pages,widgets}

# ─── Feature: Home (Phase 3) ───
print_step "Creating home module..."
mkdir -p lib/features/home/presentation/{pages,widgets}

# ─── Feature: KYC ───
print_step "Creating kyc module..."
mkdir -p lib/features/kyc/data/{datasources,models,repositories}
mkdir -p lib/features/kyc/domain/{entities,repositories,usecases}
mkdir -p lib/features/kyc/presentation/{bloc,pages,widgets}

# ─── Feature: Wallet (Phase 4) ───
print_step "Creating wallet module..."
mkdir -p lib/features/wallet/data/{datasources,models,repositories}
mkdir -p lib/features/wallet/domain/{entities,repositories,usecases}
mkdir -p lib/features/wallet/presentation/{bloc,pages,widgets}

# ─── Feature: Bill Payment (Phase 5) ───
print_step "Creating bill_payment module..."
mkdir -p lib/features/bill_payment/data/{datasources,models,repositories}
mkdir -p lib/features/bill_payment/domain/{entities,repositories,usecases}
mkdir -p lib/features/bill_payment/presentation/{bloc,pages,widgets}

# ─── Feature: Cashback (Phase 6) ───
print_step "Creating cashback module..."
mkdir -p lib/features/cashback/data/{datasources,models,repositories}
mkdir -p lib/features/cashback/domain/{entities,repositories,usecases}
mkdir -p lib/features/cashback/presentation/{bloc,pages,widgets}

# ─── Feature: Transactions (Phase 7) ───
print_step "Creating transactions module..."
mkdir -p lib/features/transactions/data/{datasources,models,repositories}
mkdir -p lib/features/transactions/domain/{entities,repositories,usecases}
mkdir -p lib/features/transactions/presentation/{bloc,pages,widgets}

# ─── Feature: Profile (Phase 8) ───
print_step "Creating profile module..."
mkdir -p lib/features/profile/data/{datasources,models,repositories}
mkdir -p lib/features/profile/domain/{entities,repositories,usecases}
mkdir -p lib/features/profile/presentation/{bloc,pages,widgets}

# ─── Feature: Notifications (Phase 9) ───
print_step "Creating notifications module..."
mkdir -p lib/features/notifications/data/{datasources,models,repositories}
mkdir -p lib/features/notifications/domain/{entities,repositories,usecases}
mkdir -p lib/features/notifications/presentation/{bloc,pages,widgets}

# ─── Feature: Referral (Phase 9) ───
print_step "Creating referral module..."
mkdir -p lib/features/referral/data/{datasources,models,repositories}
mkdir -p lib/features/referral/domain/{entities,repositories,usecases}
mkdir -p lib/features/referral/presentation/{bloc,pages,widgets}

# ─── Shared ───
print_step "Creating shared folders..."
mkdir -p lib/shared/{models,widgets,mixins,services}

# ─── Assets ───
print_step "Creating assets folders..."
mkdir -p assets/{images,icons,animations,fonts}

# ─── Tests ───
print_step "Creating test folders..."
mkdir -p test/{core,features,integration,helpers}

# ─── Env files ───
touch .env.dev .env.staging .env.prod 2>/dev/null || true

print_success "Folder structure created!"

# =============================================================
# 🩺 STEP 7: Flutter Doctor Check
# =============================================================

print_header "🩺 Step 7: Running Flutter Doctor"
flutter doctor

# =============================================================
# 📊 STEP 8: Project Status Check
# =============================================================

print_header "📊 Step 8: Project Status"

echo ""
echo "Checking which phases are complete..."
echo ""

# Phase 1: Core
PHASE1_COUNT=0
[ -f "lib/core/constants/app_colors.dart" ] && ((PHASE1_COUNT++)) || true
[ -f "lib/core/theme/app_theme.dart" ] && ((PHASE1_COUNT++)) || true
[ -f "lib/core/widgets/custom_button.dart" ] && ((PHASE1_COUNT++)) || true
[ -f "lib/core/utils/validators.dart" ] && ((PHASE1_COUNT++)) || true
[ -f "lib/core/extensions/context_extensions.dart" ] && ((PHASE1_COUNT++)) || true

if [ $PHASE1_COUNT -eq 5 ]; then
    echo -e "  ${GREEN}✅ Phase 1: Core Setup${NC} (Theme + Constants + Widgets)"
else
    echo -e "  ${YELLOW}⏳ Phase 1: Core Setup${NC} ($PHASE1_COUNT/5 files)"
fi

# Phase 2: Auth
PHASE2_COUNT=0
[ -f "lib/features/auth/presentation/pages/login_page.dart" ] && ((PHASE2_COUNT++)) || true
[ -f "lib/features/auth/presentation/pages/otp_page.dart" ] && ((PHASE2_COUNT++)) || true
[ -f "lib/features/auth/presentation/bloc/auth_bloc.dart" ] && ((PHASE2_COUNT++)) || true
[ -f "lib/features/auth/domain/entities/user.dart" ] && ((PHASE2_COUNT++)) || true
[ -f "lib/features/auth/data/repositories/auth_repository_impl.dart" ] && ((PHASE2_COUNT++)) || true

if [ $PHASE2_COUNT -eq 5 ]; then
    echo -e "  ${GREEN}✅ Phase 2: Auth Module${NC} (Login + OTP + Bloc)"
else
    echo -e "  ${YELLOW}⏳ Phase 2: Auth Module${NC} ($PHASE2_COUNT/5 files)"
fi

# Phase 3: Home Dashboard
PHASE3_COUNT=0
[ -f "lib/features/home/presentation/pages/home_page.dart" ] && ((PHASE3_COUNT++)) || true
[ -f "lib/features/home/presentation/pages/main_wrapper_page.dart" ] && ((PHASE3_COUNT++)) || true
[ -f "lib/features/home/presentation/widgets/wallet_balance_card.dart" ] && ((PHASE3_COUNT++)) || true
[ -f "lib/features/home/presentation/widgets/quick_actions_grid.dart" ] && ((PHASE3_COUNT++)) || true
[ -f "lib/features/home/presentation/widgets/recent_transactions_section.dart" ] && ((PHASE3_COUNT++)) || true

if [ $PHASE3_COUNT -eq 5 ]; then
    echo -e "  ${GREEN}✅ Phase 3: Home Dashboard${NC} (Cards + Nav + Widgets)"
else
    echo -e "  ${YELLOW}⏳ Phase 3: Home Dashboard${NC} ($PHASE3_COUNT/5 files)"
fi

# Future phases
echo -e "  ${CYAN}⬜ Phase 4: Wallet Module${NC} (Coming soon)"
echo -e "  ${CYAN}⬜ Phase 5: Bill Payment + BBPS${NC} (Coming soon)"
echo -e "  ${CYAN}⬜ Phase 6: Cashback Engine${NC} (Coming soon)"
echo -e "  ${CYAN}⬜ Phase 7: Transactions History${NC} (Coming soon)"
echo -e "  ${CYAN}⬜ Phase 8: Profile + Settings${NC} (Coming soon)"
echo -e "  ${CYAN}⬜ Phase 9: Notifications + Referral${NC} (Coming soon)"
echo -e "  ${CYAN}⬜ Phase 10: KYC + Tests + Polish${NC} (Coming soon)"

# =============================================================
# 🎯 STEP 9: Final Verification
# =============================================================

print_header "🎯 Step 9: Code Verification"

if [ -f "pubspec.yaml" ]; then
    print_step "Running flutter analyze..."
    flutter analyze --no-fatal-warnings --no-fatal-infos 2>&1 | tail -5
fi

# =============================================================
# 🎉 DONE!
# =============================================================

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}                                                  ${GREEN}║${NC}"
echo -e "${GREEN}║${NC}    ${GREEN}✅ PayEase Setup Complete!${NC} 🎉              ${GREEN}║${NC}"
echo -e "${GREEN}║${NC}                                                  ${GREEN}║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}📋 NEXT STEPS:${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BLUE}1️⃣  Run the app (Web):${NC}"
echo -e "      ${GREEN}flutter run -d chrome${NC}"
echo ""
echo -e "      ${BLUE}OR for web server (GitHub Codespaces / Gitpod):${NC}"
echo -e "      ${GREEN}flutter run -d web-server --web-hostname=0.0.0.0 --web-port=3000${NC}"
echo ""
echo -e "  ${BLUE}2️⃣  Check for issues:${NC}"
echo -e "      ${GREEN}flutter analyze${NC}"
echo ""
echo -e "  ${BLUE}3️⃣  Build production web:${NC}"
echo -e "      ${GREEN}flutter build web${NC}"
echo ""
echo -e "  ${BLUE}4️⃣  Push to GitHub:${NC}"
echo -e "      ${GREEN}git add . && git commit -m 'Setup complete' && git push${NC}"
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}💡 DEMO CREDENTIALS:${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BLUE}📱 Mobile:${NC} Any 10-digit number (e.g., 9876543210)"
echo -e "  ${BLUE}🔢 OTP:${NC}    ${GREEN}123456${NC}"
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}🔥 Happy Coding with PayEase! 💪${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""