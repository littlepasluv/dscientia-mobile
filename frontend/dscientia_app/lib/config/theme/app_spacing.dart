abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
}

abstract final class AppBreakpoints {
  static const double compact = 600;
  static const double medium = 900;
  static const double expanded = 1200;
}

abstract final class AppLayout {
  static const double maxContentWidth = 1200;
  static const double compactPagePadding = AppSpacing.md;
  static const double mediumPagePadding = AppSpacing.lg;
  static const double expandedPagePadding = AppSpacing.xl;
}
