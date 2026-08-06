import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';

class AppPageShell extends StatelessWidget {
  const AppPageShell({
    super.key,
    required this.child,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.scrollable = true,
    this.topPadding = AppSpacing.lg,
    this.bottomPadding = AppSpacing.xxl,
  });

  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool scrollable;
  final double topPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = _horizontalPaddingFor(
              constraints.maxWidth,
            );

            final content = Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppLayout.maxContentWidth,
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    topPadding,
                    horizontalPadding,
                    bottomPadding,
                  ),
                  child: SizedBox(width: double.infinity, child: child),
                ),
              ),
            );

            if (!scrollable) {
              return content;
            }

            return SingleChildScrollView(child: content);
          },
        ),
      ),
    );
  }

  double _horizontalPaddingFor(double width) {
    if (width < AppBreakpoints.compact) {
      return AppLayout.compactPagePadding;
    }

    if (width < AppBreakpoints.medium) {
      return AppLayout.mediumPagePadding;
    }

    return AppLayout.expandedPagePadding;
  }
}
