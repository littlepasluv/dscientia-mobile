import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_radius.dart';
import '../../config/theme/app_spacing.dart';

enum AppStatusTone { neutral, info, success, warning, error, ai }

class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.label,
    this.tone = AppStatusTone.neutral,
    this.icon,
  });

  final String label;
  final AppStatusTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = _colorsFor(tone);
    final textStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
      color: colors.foreground,
      fontWeight: FontWeight.w600,
    );

    return Semantics(
      container: true,
      label: label,
      child: ExcludeSemantics(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xxs,
          ),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: colors.foreground),
                const SizedBox(width: AppSpacing.xxs),
              ],
              Text(label, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }

  _AppStatusColors _colorsFor(AppStatusTone tone) {
    return switch (tone) {
      AppStatusTone.neutral => const _AppStatusColors(
        background: AppColors.surfaceStrong,
        foreground: AppColors.textSecondary,
      ),
      AppStatusTone.info => const _AppStatusColors(
        background: AppColors.infoContainer,
        foreground: AppColors.onInfoContainer,
      ),
      AppStatusTone.success => const _AppStatusColors(
        background: AppColors.successContainer,
        foreground: AppColors.onSuccessContainer,
      ),
      AppStatusTone.warning => const _AppStatusColors(
        background: AppColors.warningContainer,
        foreground: AppColors.onWarningContainer,
      ),
      AppStatusTone.error => const _AppStatusColors(
        background: AppColors.errorContainer,
        foreground: AppColors.onErrorContainer,
      ),
      AppStatusTone.ai => const _AppStatusColors(
        background: AppColors.aiContainer,
        foreground: AppColors.onAiContainer,
      ),
    };
  }
}

class _AppStatusColors {
  const _AppStatusColors({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}
