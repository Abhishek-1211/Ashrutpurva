import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final double breakpoint;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.desktop,
    this.breakpoint = 800,
  });

  static bool isMobile(BuildContext context, {double breakpoint = 800}) =>
      MediaQuery.of(context).size.width < breakpoint;

  static bool isDesktop(BuildContext context, {double breakpoint = 800}) =>
      MediaQuery.of(context).size.width >= breakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= breakpoint) {
          return desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}
