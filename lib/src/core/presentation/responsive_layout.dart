import 'package:flutter/material.dart';

/// Utility class for responsive breakpoints
class ResponsiveBreakpoints {
  static const double tablet = 600;
  static const double desktop = 1200;
  static const double maxContentWidth = 800;
}

/// A widget that provides information about the current screen size
/// and allows content to be constrained to a maximum width.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.child,
    this.useMaxWidth = true,
  });

  final Widget child;
  final bool useMaxWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= ResponsiveBreakpoints.tablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= ResponsiveBreakpoints.desktop;

  @override
  Widget build(BuildContext context) {
    if (!useMaxWidth || !isTablet(context)) {
      return child;
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: ResponsiveBreakpoints.maxContentWidth,
        ),
        child: child,
      ),
    );
  }
}
