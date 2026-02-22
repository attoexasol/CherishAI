// lib/core/utils/responsive.dart
import 'package:flutter/material.dart';

/// Breakpoints aligned with common Tailwind/React defaults (no tailwind.config in repo).
/// Use MediaQuery of context for layout switches.
abstract class Breakpoints {
  static const double xs = 0;
  static const double sm = 640;
  static const double md = 768;
  static const double lg = 1024;
  static const double xl = 1280;
}

extension ResponsiveContext on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  bool get isXs => width < Breakpoints.sm;
  bool get isSm => width >= Breakpoints.sm && width < Breakpoints.md;
  bool get isMd => width >= Breakpoints.md && width < Breakpoints.lg;
  bool get isLg => width >= Breakpoints.lg && width < Breakpoints.xl;
  bool get isXl => width >= Breakpoints.xl;
}

/// Returns value for current breakpoint. [values] order: xs, sm, md, lg, xl.
T valueByBreakpoint<T>(BuildContext context, List<T> values) {
  assert(values.length == 5, 'Provide 5 values: [xs, sm, md, lg, xl]');
  final w = MediaQuery.sizeOf(context).width;
  if (w >= Breakpoints.xl) return values[4];
  if (w >= Breakpoints.lg) return values[3];
  if (w >= Breakpoints.md) return values[2];
  if (w >= Breakpoints.sm) return values[1];
  return values[0];
}
