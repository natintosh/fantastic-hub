import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/views/ui/widgets/app_control_tile.dart';
import 'package:iconforest_icon_park/icon_park.dart';
import 'package:rxdart/rxdart.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

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
      children: [
        const Gap(40),
        AppControlCircularProgress(
          valueStream: progressStream,
          onChanged: _progressSubject.add,
        ),
        const Gap(40),
        AppControlSwitch(
          label: 'Samsung AC',
          valueStream: Stream.value(true),
          onChanged: (value) {},
        ),
        const Gap(20),
        AppControlModeSelector(
          label: 'Mode',
          modes: [
            DeviceMode(
              label: 'Cool',
              asset: IconPark.snowflake,
            ),
            DeviceMode(
              label: 'Air',
              asset: IconPark.wind,
            ),
            DeviceMode(
              label: 'Hot',
              asset: IconPark.sun,
            ),
            DeviceMode(
              label: 'Eco',
              asset: IconPark.leaves,
            ),
          ],
        ),
        const Gap(20),
        const AppControlTimerSelector(
          label: 'Timer',
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Air Conditioning'),
            Text(
              'Living Room',
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
