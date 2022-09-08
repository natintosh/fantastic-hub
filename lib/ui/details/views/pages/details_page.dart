import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hub/__core__/app_router.gr.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/views/ui/widgets/app_control_tile.dart';
import 'package:hub/__core__/views/ui/widgets/color_picker_widget.dart';
import 'package:hub/ui/details/models/data/device.dart';
import 'package:iconforest_icon_park/icon_park.dart';
import 'package:rxdart/rxdart.dart';

//[
//         const Gap(20),
//         const ColorPickerView(),
//         AppControlCircularProgress(
//           valueStream: progressStream,
//           onChanged: _progressSubject.add,
//         ),
//         AppControlSwitch(
//           label: 'Power',
//           valueStream: Stream.value(true),
//           onChanged: (value) {},
//         ),
//         AppControlModeSelector(
//           label: 'Mode',
//           modes: [
//             DeviceMode(
//               label: 'Cool',
//               asset: IconPark.snowflake,
//             ),
//             DeviceMode(
//               label: 'Air',
//               asset: IconPark.wind,
//             ),
//             DeviceMode(
//               label: 'Hot',
//               asset: IconPark.sun,
//             ),
//             DeviceMode(
//               label: 'Eco',
//               asset: IconPark.leaves,
//             ),
//           ],
//         ),
//         const Gap(20),
//         const AppControlTimerSelector(
//           label: 'Timer',
//         ),
//       ]

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.device, required this.controls});

  final Device device;
  final List<AppControlTile> controls;

  static void tv(
      {required BuildContext context, required Device device}) {
    context.router.push(
      DetailsRouter(
        device: device,
        controls: [
          const AppControlSwitch(label: 'Power'),
          AppControlModeSelector(
            label: 'Quick action',
            modes: const [
              DeviceMode(
                id: 0,
                label: 'Standby',
                asset: IconPark.power,
              ),
              DeviceMode(
                id: 1,
                label: 'Wifi',
                asset: IconPark.wifi,
              ),
              DeviceMode(
                id: 2,
                label: 'Cast',
                asset: IconPark.cast_screen,
              ),
            ],
          ),
          const AppControlDirectionPad(),
          const AppControlMedia(),
          const AppControlSlider(label: 'Volume'),
        ],
      ),
    );
  }

  static void voiceAssistant(
      {required BuildContext context, required Device device}) {
    context.router.push(
      DetailsRouter(
        device: device,
        controls: [
          const AppControlSwitch(label: 'Power'),
          AppControlModeSelector(
            label: 'Quick action',
            modes: const [
              DeviceMode(
                id: 0,
                label: '',
                asset: IconPark.wifi,
              ),
              DeviceMode(
                id: 1,
                label: '',
                asset: IconPark.voice_off,
              ),
              DeviceMode(
                id: 2,
                label: '',
                asset: IconPark.alarm_clock,
              ),
            ],
          ),
          const AppControlSlider(label: 'Volume'),
          const AppControlMedia(),
        ],
      ),
    );
  }

  static void airConditioner(
      {required BuildContext context, required Device device}) {
    context.router.push(
      DetailsRouter(
        device: device,
        controls: [
          const AppControlSwitch(
            label: 'Power',
          ),
          AppControlModeSelector(
            label: 'Mode',
            modes: const [
              DeviceMode(
                id: 0,
                label: 'Cool',
                asset: IconPark.snowflake,
              ),
              DeviceMode(
                id: 1,
                label: 'Air',
                asset: IconPark.wind,
              ),
              DeviceMode(
                id: 2,
                label: 'Hot',
                asset: IconPark.sun,
              ),
              DeviceMode(
                id: 3,
                label: 'Eco',
                asset: IconPark.leaves,
              ),
            ],
          ),
          const AppControlCircularProgress(
            label: 'Temperature',
            labelText: 'Celsius',
          ),
          const AppControlTimerSelector(
            label: 'Timer',
          ),
        ],
      ),
    );
  }

  static void lamp({required BuildContext context, required Device device}) {
    context.router.push(
      DetailsRouter(
        device: device,
        controls: const [
          AppControlSwitch(
            label: 'Power',
          ),
          AppControlTimerSelector(
            label: 'Timer',
          ),
          AppControlColorPicker(
            label: 'Ambient',
          ),
          AppControlSlider(
            label: 'Intensity',
          ),
        ],
      ),
    );
  }

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  final BehaviorSubject<double> _progressSubject = BehaviorSubject.seeded(0);

  Stream<double> get progressStream => _progressSubject.stream;

  @override
  void dispose() {
    _progressSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
      children: widget.controls,
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(widget.device.name),
            Text(
              widget.device.location,
              style: context.theme.textTheme.bodySmall,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FluentIcons.grid_24_filled),
          ),
        ],
      ),
      body: content,
    );
  }
}
