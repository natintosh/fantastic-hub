import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hub/__core__/components/views/widgets/app_grid_view.dart';
import 'package:hub/__core__/components/views/widgets/smart_widget.dart';
import 'package:hub/views/devices/models/data/device.dart';
import 'package:hub/views/details/views/pages/details_page.dart';
import 'package:hub/views/devices/views/widgets/add_device_dialog.dart';
import 'package:hub/views/location/models/data/location.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  late final List<Device> devices = List.generate(
    7,
    (index) {
      final random = Random().nextInt(100);
      final type = random < 20
          ? DeviceType.bulb
          : random < 40
              ? DeviceType.television
              : random < 60
                  ? DeviceType.airConditioner
                  : DeviceType.voiceAssistant;

      return Device(
        name: '${type.name} $index',
        location: Location(id: 1, name: 'Living Room'),
        type: type,
      );
    },
  );

  void onDeviceTap(Device device) {
    DetailsPage.pushOnType(context: context, device: device);
  }

  void onAddNewDeviceButtonPressed() {
    AddDeviceDialog.showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppGridView(
        children: [
          for (final device in devices)
            SmartWidget(
              device: device,
              onTap: onDeviceTap,
            ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Devices'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onAddNewDeviceButtonPressed,
        label: const Text('Add Device'),
      ),
      body: content,
    );
  }
}
