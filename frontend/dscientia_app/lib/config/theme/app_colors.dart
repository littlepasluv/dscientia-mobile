import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF0F766E);
  static const Color primaryHover = Color(0xFF115E59);
  static const Color primaryContainer = Color(0xFFCCFBF1);
  static const Color onPrimaryContainer = Color(0xFF134E4A);

  // Supporting and AI-specific accents
  static const Color secondary = Color(0xFF2563EB);
  static const Color secondaryContainer = Color(0xFFDBEAFE);
  static const Color onSecondaryContainer = Color(0xFF1E3A8A);
  static const Color aiAccent = Color(0xFF7C3AED);
  static const Color aiContainer = Color(0xFFEDE9FE);
  static const Color onAiContainer = Color(0xFF5B21B6);

  // Surfaces
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSubtle = Color(0xFFF1F5F9);
  static const Color surfaceStrong = Color(0xFFE2E8F0);

  // Text and borders
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF64748B);
  static const Color outline = Color(0xFFCBD5E1);
  static const Color outlineStrong = Color(0xFF94A3B8);

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

  static const Color info = Color(0xFF1D4ED8);
  static const Color infoContainer = Color(0xFFDBEAFE);
  static const Color onInfoContainer = Color(0xFF1E3A8A);

  // Effects
  static const Color shadow = Color(0x1A0F172A);
}
