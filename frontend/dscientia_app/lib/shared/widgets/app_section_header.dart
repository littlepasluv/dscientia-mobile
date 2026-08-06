import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';

class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.bottomSpacing = AppSpacing.md,
  });

  final String title;
  final String? description;
  final Widget? action;
  final double bottomSpacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < AppBreakpoints.compact;

        final heading = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: Text(title, style: theme.textTheme.titleLarge),
            ),
            if (description != null) ...[
              const SizedBox(height: AppSpacing.xxs),
              Text(description!, style: theme.textTheme.bodyMedium),
            ],
          ],
        );

        final content = isCompact || action == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading,
                  if (action != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    action!,
                  ],
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: heading),
                  const SizedBox(width: AppSpacing.lg),
                  action!,
                ],
              );

        return Padding(
          padding: EdgeInsets.only(bottom: bottomSpacing),
          child: content,
        );
      },
    );
  }
}
