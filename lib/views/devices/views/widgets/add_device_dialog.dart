import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/components/styles/app_colors.dart';
import 'package:hub/__core__/components/views/widgets/app_text_field.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/views/details/models/data/device.dart';

class AddDeviceDialog extends StatefulWidget {
  const AddDeviceDialog({super.key, required this.draggableScrollController});

  final ScrollController draggableScrollController;

  static Future<void> showDialog(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(builder: (context, controller) {
          return AddDeviceDialog(draggableScrollController: controller);
        });
      },
    );
  }

  @override
  State<AddDeviceDialog> createState() => _AddDeviceDialogState();
}

class _AddDeviceDialogState extends State<AddDeviceDialog> {
  List<DeviceType> deviceTypes = DeviceType.values;

  DeviceType? selectedType;

  void onDeviceTypeSelected(DeviceType type) {
    selectedType = type;
    setState(() {});
  }

  void onAddDevice() {}

  @override
  Widget build(BuildContext context) {
    final content = ListView(
      controller: widget.draggableScrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      children: [
        const Gap(20),
        AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Add Device'),
        ),
        const Gap(20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'DEVICE NAME',
            style: context.theme.textTheme.bodySmall,
          ),
        ),
        const Gap(8),
        const AppTextField.stream(valueStream: Stream.empty()),
        const Gap(20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'DEVICE TYPE',
            style: context.theme.textTheme.bodySmall,
          ),
        ),
        const Gap(8),
        Wrap(
          spacing: 8.0,
          children: [
            for (final type in deviceTypes)
              ChoiceChip(
                selected: type == selectedType,
                onSelected: (_) => onDeviceTypeSelected(type),
                label: Text(type.name),
              ),
          ],
        ),
        const Gap(20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'LOCATION',
            style: context.theme.textTheme.bodySmall,
          ),
        ),
        const Gap(8),
        Wrap(
          spacing: 8.0,
          children: [
            for (final type in deviceTypes)
              ChoiceChip(
                selected: type == selectedType,
                onSelected: (_) => onDeviceTypeSelected(type),
                label: Text(type.name),
              ),
          ],
        ),
        const Gap(20),
        SizedBox(height: context.mq.viewInsets.bottom),
        ElevatedButton(
          onPressed: onAddDevice,
          child: const Text('Add Device'),
        ),
        const Gap(50),
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
