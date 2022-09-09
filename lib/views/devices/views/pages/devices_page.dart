import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hub/__core__/components/views/widgets/app_grid_view.dart';
import 'package:hub/__core__/components/views/widgets/smart_widget.dart';
import 'package:hub/views/details/views/pages/details_page.dart';
import 'package:hub/views/devices/models/data/device.dart';
import 'package:hub/views/devices/viewmodels/device_viewmodels.dart';
import 'package:hub/views/devices/views/widgets/add_device_dialog.dart';
import 'package:provider/provider.dart';

class DevicesPage extends StatefulWidget with AutoRouteWrapper {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeviceViewModel(),
      child: this,
    );
  }
}

class _DevicesPageState extends State<DevicesPage> {
  late final DeviceViewModel viewModel;

  @override
  void initState() {
    viewModel = context.read<DeviceViewModel>();
    super.initState();
  }

  void onDeviceTap(Device device) {
    DetailsPage.pushOnType(context: context, device: device);
  }

  Future<void> onAddNewDeviceButtonPressed() async {
    final device = await AddDeviceDialog.showDialog(
      context,
      locations: viewModel.getLocation(),
    );

    if (device != null) {
      viewModel.addDevice(device);
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = StreamBuilder<List<Device>>(
        stream: viewModel.getDevices(),
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppGridView(
              children: [
                for (final device in data)
                  SmartWidget(
                    device: device,
                    onTap: onDeviceTap,
                  ),
              ],
            ),
          );
        });

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
