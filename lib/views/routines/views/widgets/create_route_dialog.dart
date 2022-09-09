import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/components/styles/app_colors.dart';
import 'package:hub/__core__/components/views/widgets/app_text_field.dart';
import 'package:hub/__core__/components/views/widgets/multi_day_picker.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/views/details/views/pages/details_page.dart';
import 'package:hub/views/devices/models/data/device.dart';
import 'package:hub/views/devices/views/widgets/device_item_tile.dart';
import 'package:hub/views/devices/views/widgets/device_list_dialog.dart';
import 'package:hub/views/routines/models/data/routine.dart';
import 'package:hub/views/routines/viewmodels/routine_viewmodel.dart';
import 'package:provider/provider.dart';

class CreateRouteDialog extends StatefulWidget {
  const CreateRouteDialog({super.key, required this.draggableScrollController});

  final ScrollController draggableScrollController;

  static Future<Routine?> showDialog(BuildContext context,
      {required RoutineViewModel viewModel}) {
    return showModalBottomSheet<Routine>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          builder: (context, scrollController) {
            return ChangeNotifierProvider.value(
              value: viewModel,
              child: CreateRouteDialog(
                draggableScrollController: scrollController,
              ),
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
  late final RoutineViewModel viewModel;

  late final TextEditingController startDateController =
      TextEditingController();

  late final TextEditingController endDateController = TextEditingController();

  late Routine newRoutine = Routine.empty();

  @override
  void initState() {
    viewModel = context.read<RoutineViewModel>();
    super.initState();
  }

  List<Device> selectedDevices = [];

  void onSaveNewRoutine() {
    if (newRoutine.name.isNotEmpty &&
        newRoutine.startTime != null &&
        newRoutine.endTime != null &&
        newRoutine.days.isNotEmpty) {
      Navigator.pop(context, newRoutine);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Not sure what went wrong. Enter data and try again',
            style: context.theme.textTheme.bodyMedium
                ?.copyWith(color: context.theme.colorScheme.onErrorContainer),
          ),
          backgroundColor: context.theme.colorScheme.errorContainer,
        ),
      );
    }
  }

  void onDevicePressed(Device device) {
    DetailsPage.pushOnType(context: context, device: device);
  }

  void onScheduleNameChanged(String value) {
    newRoutine = newRoutine.copyWith(name: value);
  }

  void onStartTimeSet(TimeOfDay time) {
    newRoutine = newRoutine.copyWith(startTime: time);
  }

  void onEndTimeSet(TimeOfDay time) {
    newRoutine = newRoutine.copyWith(endTime: time);
  }

  void onDaysSelected(List<String> days) {
    newRoutine = newRoutine.copyWith(days: days);
  }

  Future<void> onAddDevicePressed() async {
    final devices = DeviceListDialog.showDialog(
      context,
      devices: viewModel.getAllDevices(),
      selectedDevices: selectedDevices,
    );

    selectedDevices = (await devices) ?? selectedDevices;
    newRoutine = newRoutine.copyWith(devices: selectedDevices);
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
        AppTextField.text(onChanged: onScheduleNameChanged),
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
                    onTimeSet: onStartTimeSet,
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
                    onTimeSet: onEndTimeSet,
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
            'SELECT DAYS',
            style: context.theme.textTheme.bodySmall,
          ),
        ),
        const Gap(8),
        MultiDayPicker(
          onChanged: onDaysSelected,
        ),
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
      child: Scaffold(body: content),
    );
  }
}
