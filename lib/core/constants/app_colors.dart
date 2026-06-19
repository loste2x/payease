import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ═══════════════════════════════════════════════════
  // 🎨 PayEase Brand Colors (Material 3 Compatible)
  // ═══════════════════════════════════════════════════

  // Seed color for M3 ColorScheme
  static const Color seed = Color(0xFF1565C0);

  // Brand Primary
  static const Color primary = Color(0xFF0B57D0);
  static const Color primaryContainer = Color(0xFFD8E2FF);
  static const Color onPrimary = Colors.white;
  static const Color onPrimaryContainer = Color(0xFF001A41);

  // Secondary (Success/Money)
  static const Color secondary = Color(0xFF00A86B);
  static const Color secondaryContainer = Color(0xFFB8F5D0);
  static const Color onSecondary = Colors.white;

  // Tertiary (Cashback/Offers)
  static const Color tertiary = Color(0xFFFF6D00);
  static const Color tertiaryContainer = Color(0xFFFFDCC2);
  static const Color onTertiary = Colors.white;

  // Status Colors (M3 aligned)
  static const Color success = Color(0xFF10B981);
  static const Color successContainer = Color(0xFFD1FAE5);
  static const Color error = Color(0xFFDC2626);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoContainer = Color(0xFFDBEAFE);

  // M3 Surface Tonal Palette (Light)
  static const Color surface = Color(0xFFFDFCFF);
  static const Color surfaceDim = Color(0xFFDDD9DD);
  static const Color surfaceBright = Color(0xFFFDFCFF);
  static const Color surfaceContainerLowest = Colors.white;
  static const Color surfaceContainerLow = Color(0xFFF7F2FA);
  static const Color surfaceContainer = Color(0xFFF1ECF4);
  static const Color surfaceContainerHigh = Color(0xFFEBE6EE);
  static const Color surfaceContainerHighest = Color(0xFFE6E0E9);

  // Background
  static const Color background = Color(0xFFFDFCFF);
  static const Color scaffoldBg = Color(0xFFF6F7FB);

  // Text (M3 onSurface variants)
  static const Color onSurface = Color(0xFF1B1B1F);
  static const Color onSurfaceVariant = Color(0xFF44474F);
  static const Color outline = Color(0xFF74777F);
  static const Color outlineVariant = Color(0xFFC4C6D0);

  // Legacy aliases (for backward compatibility)
  static const Color textPrimary = onSurface;
  static const Color textSecondary = onSurfaceVariant;
  static const Color textHint = outline;
  static const Color border = outlineVariant;
  static const Color divider = Color(0xFFE7E0EC);

  // ═══════════════════════════════════════════════════
  // 🌈 Gradients (For Premium Feel)
  // ═══════════════════════════════════════════════════

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0B57D0), Color(0xFF4285F4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient walletGradient = LinearGradient(
    colors: [Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFF5C6BC0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cashbackGradient = LinearGradient(
    colors: [Color(0xFFFF6D00), Color(0xFFFFAB00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF00A86B), Color(0xFF00C853)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ═══════════════════════════════════════════════════
  // 🏆 Loyalty Tier Colors
  // ═══════════════════════════════════════════════════

  static const Color bronze = Color(0xFFCD7F32);
  static const Color silver = Color(0xFFB0B7BD);
  static const Color gold = Color(0xFFFFC107);
  static const Color platinum = Color(0xFF9C27B0);
}
