import 'package:flutter/material.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/views/styles/app_colors.dart';
import 'package:hub/__core__/views/ui/widgets/app_rounded_container.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.text,
  });

  const factory AppHeader.withAction({
    required String text,
    required Widget action,
    VoidCallback? onAction,
  }) = _AppHeaderWithAction;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: context.theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}

class _AppHeaderWithAction extends AppHeader {
  const _AppHeaderWithAction({
    required super.text,
    required this.action,
    this.onAction,
  });

  final VoidCallback? onAction;

  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: super.build(context),
        ),
        AppRoundedContainer(
          child: Material(
            color: AppColors.transparent,
            child: InkWell(
              onTap: onAction,
              radius: 16,
              child: action,
            ),
          ),
        ),
      ],
    );
  }
}
