import 'package:flutter/material.dart';

import '../../config/theme/app_radius.dart';
import '../../config/theme/app_spacing.dart';

class AppHeroCard extends StatelessWidget {
  const AppHeroCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.action,
    this.trailing,
    this.accentColor,
  });

  final String title;
  final String description;
  final IconData icon;
  final Widget? action;
  final Widget? trailing;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedAccentColor = accentColor ?? theme.colorScheme.primary;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < AppBreakpoints.compact;

          final mainContent = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: resolvedAccentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(
                      icon,
                      color: resolvedAccentColor,
                      semanticLabel: title,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Semantics(
                          header: true,
                          child: Text(
                            title,
                            style: isCompact
                                ? theme.textTheme.headlineSmall
                                : theme.textTheme.headlineMedium,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(description, style: theme.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ],
              ),
              if (action != null) ...[
                const SizedBox(height: AppSpacing.lg),
                action!,
              ],
            ],
          );

          final content = isCompact || trailing == null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mainContent,
                    if (trailing != null) ...[
                      const SizedBox(height: AppSpacing.lg),
                      Align(alignment: Alignment.centerLeft, child: trailing!),
                    ],
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: mainContent),
                    const SizedBox(width: AppSpacing.xl),
                    Flexible(child: trailing!),
                  ],
                );

          return Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: resolvedAccentColor, width: 4),
              ),
            ),
            padding: EdgeInsets.all(isCompact ? AppSpacing.md : AppSpacing.lg),
            child: content,
          );
        },
      ),
    );
  }
}
