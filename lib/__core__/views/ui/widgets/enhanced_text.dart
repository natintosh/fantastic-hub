import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EnhancedText extends StatelessWidget {
  const EnhancedText({
    required this.text,
    this.gap = 8,
    this.textStyle,
    this.prefix,
    this.suffix,
    super.key,
  });

  final String text;
  final TextStyle? textStyle;
  final Widget? prefix;
  final Widget? suffix;

  final double gap;

  Widget get prefixView => Row(
        children: [
          prefix ?? const SizedBox.shrink(),
          if (prefix != null) Gap(gap),
        ],
      );

  Widget get suffixView => Row(
        children: [
          if (suffix != null) Gap(gap),
          suffix ?? const SizedBox.shrink(),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        prefixView,
        Text(
          text,
          style: textStyle,
        ),
        suffixView,
      ],
    );
  }
}
