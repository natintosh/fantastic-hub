import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/components/styles/app_colors.dart';
import 'package:hub/__core__/components/views/widgets/app_rounded_container.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/theme.dart';
import 'package:hub/views/devices/models/data/device.dart';
import 'package:iconforest_icon_park/icon_park.dart';

class SmartWidget extends StatelessWidget {
  const SmartWidget({
    super.key,
    required this.device,
    this.onTap,
  });

  const factory SmartWidget.activeSwitch({
    Key? key,
    required Device device,
    ValueChanged<Device>? onTap,
    ValueChanged<bool>? onSwitchChanged,
  }) = _SwitchSmartWidget;

  final Device device;

  final ValueChanged<Device>? onTap;

  Widget get icon => Center(
        child: IconPark.svgAsset(device.type.icon, width: 24, height: 24),
      );

  @override
  Widget build(BuildContext context) {
    return AppRoundedContainer(
      color: context.theme.colorScheme.secondaryContainer,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: () => onTap?.call(device),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: AppRoundedContainer(
                      color: context.theme.colorScheme.surfaceElevation1,
                      child: icon,
                    ),
                  ),
                  const Gap(16),
                  Text(
                    device.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.titleMedium,
                  ),
                  const Gap(16),
                  Text(
                    device.location.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SwitchSmartWidget extends SmartWidget {
  const _SwitchSmartWidget({
    super.key,
    required super.device,
    super.onTap,
    this.onSwitchChanged,
  });

  final ValueChanged<bool>? onSwitchChanged;

  @override
  Widget build(BuildContext context) {
    return AppRoundedContainer(
      color: device.isActive
          ? context.theme.colorScheme.primaryContainer
          : context.theme.colorScheme.secondaryContainer,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: () => super.onTap?.call(device),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: AppRoundedContainer(
                    color: context.theme.colorScheme.surfaceElevation1,
                    child: icon,
                  ),
                ),
                const Gap(16),
                Text(
                  device.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.titleMedium,
                ),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        device.isActive ? 'On' : 'Off',
                        style: context.theme.textTheme.labelLarge,
                      ),
                    ),
                    Switch(
                      value: device.isActive,
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
  }
}
