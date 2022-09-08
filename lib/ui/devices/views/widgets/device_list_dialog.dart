import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/views/styles/app_colors.dart';
import 'package:hub/ui/details/models/data/device.dart';
import 'package:hub/ui/devices/views/widgets/device_item_tile.dart';

class DeviceListDialog extends StatefulWidget {
  const DeviceListDialog(
      {super.key,
      required this.draggableScrollableController,
      this.selectedDevices});

  final ScrollController draggableScrollableController;

  final List<Device>? selectedDevices;

  static Future<List<Device>?> showDialog(BuildContext context,
      {List<Device>? selectedDevices}) {
    return showModalBottomSheet<List<Device>>(
      context: context,
      backgroundColor: AppColors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          builder: (context, scrollController) {
            return DeviceListDialog(
              draggableScrollableController: scrollController,
              selectedDevices: selectedDevices,
            );
          },
        );
      },
    );
  }

  @override
  State<DeviceListDialog> createState() => _DeviceListDialogState();
}

class _DeviceListDialogState extends State<DeviceListDialog> {
  List<Device> devices = List.generate(
    8,
    (index) => Device(
        name: 'Lamp $index',
        brand: 'Phillip Hue',
        location: 'Living Room',
        type: DeviceType.smartBulb),
  );

  @override
  void initState() {
    selectedDevices.addAll(widget.selectedDevices ?? []);
    super.initState();
  }

  late Set<Device> selectedDevices = {};

  void onDeviceSelected(Device device) {
    final added = selectedDevices.add(device);

    if (!added) {
      selectedDevices.remove(device);
    }

    setState(() {});
  }

  void onSelectDevices() {
    Navigator.pop(context, selectedDevices.toList());
  }

  @override
  Widget build(BuildContext context) {
    final content = ListView(
      controller: widget.draggableScrollableController,
      shrinkWrap: true,
      children: [
        const Gap(20),
        AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Select Devices'),
          actions: [
            TextButton(
              onPressed: onSelectDevices,
              child: const Text('Select'),
            ),
          ],
        ),
        for (final device in devices)
          DeviceItemTile.selectable(
            selected: selectedDevices.contains(device),
            device: device,
            onDeviceSelected: onDeviceSelected,
          ),
      ],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: content,
    );
  }
}
