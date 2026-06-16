# 💳 PayEase

A modern fintech wallet application built with Flutter using Clean Architecture, BLoC, and GoRouter.

PayEase is designed as a scalable digital payments platform that demonstrates modern Flutter development practices, modular architecture, state management, and fintech-inspired user experiences.

---

## ✨ Features

### 🔐 Authentication
- OTP-based login flow
- Secure user onboarding
- Session management

### 👛 Wallet Management
- Wallet balance overview
- Balance tracking
- Transaction summaries

### 💸 Transactions
- Send money
- Receive money
- Transaction history
- Transaction details

### 🎁 Cashback System
- Cashback rewards tracking
- Cashback history
- Reward insights

### 👥 Referral Program
- Invite friends
- Referral rewards
- Referral tracking

### 🧾 Bill Payments
- Mobile recharge
- Utility payments
- Bill management workflows

---

## 🏗 Architecture

This project follows **Clean Architecture** principles.

```text
lib/
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   ├── theme/
│   └── utils/
│
├── features/
│   ├── auth/
│   ├── wallet/
│   ├── transactions/
│   ├── cashback/
│   ├── referrals/
│   └── bill_payments/
│
├── shared/
│   ├── widgets/
│   ├── services/
│   └── models/
│
└── main.dart
```

---

## 🧩 Tech Stack

### Frontend
- Flutter
- Dart

### State Management
- flutter_bloc

### Navigation
- go_router

### Dependency Injection
- get_it

### Local Storage
- shared_preferences

### Networking
- http / dio

### Backend (Planned)
- Firebase Authentication
- Cloud Firestore
- Firebase Messaging
- Firebase Storage

---

## 📱 Screens

### Current
- Login
- Wallet
- Transactions
- Cashback
- Referrals
- Bill Payments

### Planned
- Dashboard
- QR Payments
- Analytics
- Expense Insights
- Push Notifications
- AI Assistant

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio / VS Code
- Git

Check Flutter installation:

```bash
flutter doctor
```

---

## Installation

Clone the repository:

```bash
git clone https://github.com/loste2x/payease.git
```

Navigate into the project:

```bash
cd payease
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

---

## 🌐 Running in GitHub Codespaces

Install dependencies:

```bash
flutter pub get
```

Run web server:

```bash
flutter run -d web-server \
  --web-hostname=0.0.0.0 \
  --web-port=8080
```

Open the forwarded port in your browser.

---

## 🛣 Roadmap

### Phase 1
- Professional Dashboard
- Wallet Cards
- Recent Transactions

### Phase 2
- Transaction Filters
- Search
- Categories

### Phase 3
- QR Scanner
- QR Payments

### Phase 4
- Spending Analytics
- Charts & Reports

### Phase 5
- Firebase Integration

### Phase 6
- Push Notifications

### Phase 7
- AI Expense Assistant

### Phase 8
- Smart Cashback Recommendations

---

## 🧪 Testing

Run tests:

```bash
flutter test
```

Run analyzer:

```bash
flutter analyze
```

---

## 🤝 Contributing

Contributions are welcome.

1. Fork the repository
2. Create a feature branch

```bash
git checkout -b feature/new-feature
```

3. Commit changes

```bash
git commit -m "feat: add new feature"
```

4. Push branch

```bash
git push origin feature/new-feature
```

5. Open a Pull Request

---

## 📌 Project Goals

PayEase aims to demonstrate:

- Clean Architecture
- Scalable Flutter Development
- Fintech UI/UX Patterns
- Production-grade Code Structure
- Modular Feature Development

---

## 📄 License

This project is licensed under the MIT License.

---

## 👨‍💻 Author

**loste2x**

GitHub: https://github.com/loste2x
