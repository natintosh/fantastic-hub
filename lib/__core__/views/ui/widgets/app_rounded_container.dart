import 'package:flutter/material.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/theme.dart';

class AppRoundedContainer extends StatelessWidget {
  const AppRoundedContainer({
    required this.child,
    this.color,
    this.radius = 16,
    super.key,
  });

  final Widget child;
  final Color? color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? context.theme.colorScheme.surfaceElevation1,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(child: child),
      ),
    );
  }
}
