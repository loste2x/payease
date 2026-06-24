import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ═══════════════════════════════════════════════════
  // 🎨 PayEase Brand — MobiKwik Inspired
  // ═══════════════════════════════════════════════════

  // Brand Red (signature)
  static const Color primary = Color(0xFFE11B22);
  static const Color primaryDark = Color(0xFFB8141A);
  static const Color primaryLight = Color(0xFFFF4D52);
  static const Color primaryContainer = Color(0xFFFFE5E6);
  static const Color onPrimary = Colors.white;
  static const Color onPrimaryContainer = Color(0xFF410002);

  // Dark Navy (for hero sections)
  static const Color heroDark = Color(0xFF0A0E27);
  static const Color heroDarkLight = Color(0xFF1A1F3A);

  // Secondary (Money Green)
  static const Color secondary = Color(0xFF00C566);
  static const Color secondaryContainer = Color(0xFFD4F7E1);
  static const Color onSecondary = Colors.white;

  // Tertiary (Cashback Gold)
  static const Color tertiary = Color(0xFFFFB800);
  static const Color tertiaryContainer = Color(0xFFFFF3CC);
  static const Color onTertiary = Color(0xFF1A1A1A);

  // Status
  static const Color success = Color(0xFF00C566);
  static const Color successContainer = Color(0xFFD4F7E1);
  static const Color error = Color(0xFFE11B22);
  static const Color errorContainer = Color(0xFFFFE5E6);
  static const Color warning = Color(0xFFFFB800);
  static const Color warningContainer = Color(0xFFFFF3CC);
  static const Color info = Color(0xFF2196F3);
  static const Color infoContainer = Color(0xFFE3F2FD);

  // Surfaces
  static const Color surface = Color(0xFFFAFAFA);
  static const Color scaffoldBg = Color(0xFFF5F5F7);
  static const Color surfaceContainerLowest = Colors.white;
  static const Color surfaceContainerLow = Color(0xFFFAFAFA);
  static const Color surfaceContainer = Color(0xFFF5F5F7);
  static const Color surfaceContainerHigh = Color(0xFFEEEEEE);
  static const Color surfaceContainerHighest = Color(0xFFE5E5E5);

  // Text
  static const Color onSurface = Color(0xFF0A0E27);
  static const Color onSurfaceVariant = Color(0xFF5C5F77);
  static const Color outline = Color(0xFF8E92A8);
  static const Color outlineVariant = Color(0xFFE0E2EC);

  // Legacy aliases
  static const Color textPrimary = onSurface;
  static const Color textSecondary = onSurfaceVariant;
  static const Color textHint = outline;
  static const Color border = outlineVariant;
  static const Color divider = Color(0xFFF0F0F0);
  static const Color background = scaffoldBg;
  static const Color seed = primary;

  // ═══════════════════════════════════════════════════
  // 🌈 Gradients (Premium Vibe)
  // ═══════════════════════════════════════════════════

  // Wallet Hero — Deep Navy with Red Accent
  static const LinearGradient walletGradient = LinearGradient(
    colors: [Color(0xFF0A0E27), Color(0xFF1A1F3A), Color(0xFF2D1B5C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );

  // Primary Red Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFE11B22), Color(0xFFFF4D52)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Cashback Gold Gradient
  static const LinearGradient cashbackGradient = LinearGradient(
    colors: [Color(0xFFFFB800), Color(0xFFFFD93D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Money Green
  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF00C566), Color(0xFF00E676)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Premium Purple
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Hot Pink
  static const LinearGradient pinkGradient = LinearGradient(
    colors: [Color(0xFFEC4899), Color(0xFFF472B6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Ocean Blue
  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Hero Card Shimmer
  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [
      Color(0x00FFFFFF),
      Color(0x33FFFFFF),
      Color(0x00FFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ═══════════════════════════════════════════════════
  // 🏆 Loyalty Tiers
  // ═══════════════════════════════════════════════════
  static const Color bronze = Color(0xFFCD7F32);
  static const Color silver = Color(0xFFB0B7BD);
  static const Color gold = Color(0xFFFFB800);
  static const Color platinum = Color(0xFF9C27B0);
}