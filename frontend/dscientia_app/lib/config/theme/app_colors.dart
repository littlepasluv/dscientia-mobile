import 'package:flutter/material.dart';

abstract final class AppColors {
  // Core brand palette
  static const Color primary = Color(0xFF000887);
  static const Color primaryHover = Color(0xFF00066D);
  static const Color primaryContainer = Color(0xFFE8E9FF);
  static const Color onPrimaryContainer = Color(0xFF00045C);

  static const Color secondary = Color(0xFFED51C2);
  static const Color secondaryContainer = Color(0xFFFDE8F8);
  static const Color onSecondaryContainer = Color(0xFF6B004E);

  static const Color aiAccent = Color(0xFFED51C2);
  static const Color aiContainer = Color(0xFFFDE8F8);
  static const Color onAiContainer = Color(0xFF6B004E);

  static const Color white = Color(0xFFFFFFFF);

  // Surfaces
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSubtle = Color(0xFFF7F7FF);
  static const Color surfaceStrong = Color(0xFFE7E8F3);

  // Text and borders
  static const Color textPrimary = Color(0xFF000887);
  static const Color textSecondary = Color(0xFF3D416C);
  static const Color textMuted = Color(0xFF65698B);
  static const Color outline = Color(0xFFD7D9EA);
  static const Color outlineStrong = Color(0xFFA9ACCB);

  // Semantic states
  static const Color success = Color(0xFF15803D);
  static const Color successContainer = Color(0xFFDCFCE7);
  static const Color onSuccessContainer = Color(0xFF14532D);

  static const Color warning = Color(0xFFB45309);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color onWarningContainer = Color(0xFF78350F);

  static const Color error = Color(0xFFB91C1C);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color onErrorContainer = Color(0xFF7F1D1D);

  static const Color info = Color(0xFF000887);
  static const Color infoContainer = Color(0xFFE8E9FF);
  static const Color onInfoContainer = Color(0xFF00045C);

  // Effects
  static const Color shadow = Color(0x1A000887);
}
