import 'package:flutter/material.dart';
import 'package:hub/__core__/components/views/widgets/app_rounded_container.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/theme.dart';
import 'package:hub/views/devices/models/data/device.dart';
import 'package:iconforest_icon_park/icon_park.dart';

class DeviceItemTile extends StatelessWidget {
  const DeviceItemTile({super.key, required this.device, this.onDeviceSelected});

  const factory DeviceItemTile.selectable(
      {Key? key,
      required Device device,
      required bool selected,
      ValueChanged<Device>? onDeviceSelected}) = _SelectableDeviceItem;

  final Device device;

  final ValueChanged<Device>? onDeviceSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 48,
        height: 48,
        child: AppRoundedContainer(
          color: context.theme.colorScheme.surfaceElevation5,
          child: Center(
              child:
                  IconPark.svgAsset(device.type.icon, width: 24, height: 24)),
        ),
      ),
      title: Text(device.name),
      subtitle: Text(device.location.name),
      selectedTileColor: context.theme.colorScheme.surfaceVariant,
      onTap: () => onDeviceSelected?.call(device),
    );
  }
}

class _SelectableDeviceItem extends DeviceItemTile {
  const _SelectableDeviceItem(
      {super.key,
      required this.selected,
      required super.device,
      super.onDeviceSelected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 48,
        height: 48,
        child: AppRoundedContainer(
          color: context.theme.colorScheme.surfaceElevation5,
          child: Center(
              child:
                  IconPark.svgAsset(device.type.icon, width: 24, height: 24)),
        ),
      ),
      title: Text(device.name),
      subtitle: Text(device.location.name),
      selected: selected,
      selectedTileColor: context.theme.colorScheme.surfaceVariant,
      onTap: () => onDeviceSelected?.call(device),
    );
  }
}
