import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/theme.dart';
import 'package:hub/__core__/components/styles/app_colors.dart';
import 'package:hub/__core__/components/views/widgets/app_rounded_container.dart';

class SmartWidget extends StatelessWidget {
  const SmartWidget(
      {super.key, required this.name, required this.icon, this.onTap});

  const factory SmartWidget.activeSwitch({
    required String name,
    required Widget icon,
    VoidCallback? onTap,
    Stream<bool>? valueStream,
    ValueChanged<bool>? onSwitchChanged,
  }) = _SwitchSmartWidget;

  final String name;
  final Widget icon;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _SwitchSmartWidget extends SmartWidget {
  const _SwitchSmartWidget({
    super.key,
    required super.name,
    required super.icon,
    super.onTap,
    this.valueStream,
    this.onSwitchChanged,
  });

  final ValueChanged<bool>? onSwitchChanged;
  final Stream<bool>? valueStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: valueStream,
      builder: (context, snapshot) {
        final active = snapshot.data ?? false;

        final info = active ? 'On' : 'Off';

        return AppRoundedContainer(
          color: active
              ? context.theme.colorScheme.primaryContainer
              : context.theme.colorScheme.secondaryContainer,
          child: Material(
            color: AppColors.transparent,
            child: InkWell(
              onTap: super.onTap,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: AppRoundedContainer(
                        color: context.theme.colorScheme.surfaceElevation5,
                        child: Center(child: icon),
                      ),
                    ),
                    const Gap(16),
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.theme.textTheme.titleMedium,
                    ),
                    const Expanded(child: SizedBox()),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            info,
                            style: context.theme.textTheme.labelLarge,
                          ),
                        ),
                        Switch(
                          value: active,
                          onChanged: onSwitchChanged,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
