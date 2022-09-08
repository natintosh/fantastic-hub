import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/app_router.gr.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/views/styles/app_colors.dart';
import 'package:hub/__core__/views/ui/widgets/app_text_field.dart';
import 'package:hub/__core__/views/ui/widgets/multi_day_picker.dart';
import 'package:hub/ui/details/models/data/device.dart';
import 'package:hub/ui/details/views/pages/details_page.dart';
import 'package:hub/ui/devices/views/widgets/device_item_tile.dart';
import 'package:hub/ui/devices/views/widgets/device_list_dialog.dart';
import 'package:hub/ui/routines/views/widgets/routine_details.dart';

class CreateRouteDialog extends StatefulWidget {
  const CreateRouteDialog({super.key, required this.draggableScrollController});

  final ScrollController draggableScrollController;

  static Future<dynamic> showDialog(BuildContext context) {
    return showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          builder: (context, scrollController) {
            return CreateRouteDialog(
              draggableScrollController: scrollController,
            );
          },
        );
      },
    );
  }

  @override
  State<CreateRouteDialog> createState() => _CreateRouteDialogState();
}

class _CreateRouteDialogState extends State<CreateRouteDialog> {
  late final TextEditingController startDateController =
      TextEditingController();
  late final TextEditingController endDateController = TextEditingController();

  List<Device> selectedDevices = [];

  void onSaveNewRoutine() {}

  void onDevicePressed(Device device) {
    DetailsPage.lamp(context: context, device: device);
  }

  Future<void> onAddDevicePressed() async {
    final devices = DeviceListDialog.showDialog(context,
        selectedDevices: selectedDevices);

    selectedDevices = (await devices) ?? selectedDevices;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final content = ListView(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
      controller: widget.draggableScrollController,
      children: [
        const Gap(20),
        AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Create Routine'),
          actions: [
            TextButton(
              onPressed: onSaveNewRoutine,
              child: const Text('Save'),
            ),
          ],
        ),
        const Gap(20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'SCHEDULE NAME',
            style: context.theme.textTheme.bodySmall,
          ),
        ),
        const Gap(8),
        const AppTextField.stream(valueStream: Stream.empty()),
        const Gap(20),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'START TIME',
                      style: context.theme.textTheme.bodySmall,
                    ),
                  ),
                  const Gap(8),
                  AppTextField.time(
                    context: context,
                    controller: startDateController,
                  ),
                ],
              ),
            ),
            const Gap(20),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'END TIME',
                      style: context.theme.textTheme.bodySmall,
                    ),
                  ),
                  const Gap(8),
                  AppTextField.time(
                    context: context,
                    controller: endDateController,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Gap(20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'SELECT DATE',
            style: context.theme.textTheme.bodySmall,
          ),
        ),
        const Gap(8),
        const MultiDayPicker(),
        const Gap(20),
        ElevatedButton.icon(
          onPressed: onAddDevicePressed,
          icon: const Icon(FluentIcons.add_24_filled),
          label: const Text('Add device'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
          ),
        ),
        const Gap(20),
        for (final device in selectedDevices)
          DeviceItemTile(
            device: device,
            onDeviceSelected: onDevicePressed,
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
