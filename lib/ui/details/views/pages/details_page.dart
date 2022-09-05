import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/views/ui/widgets/app_control_tile.dart';
import 'package:hub/__core__/views/ui/widgets/circular_knob_view.dart';
import 'package:hub/__core__/views/ui/widgets/slider_dial_view.dart';
import 'package:rxdart/rxdart.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  BehaviorSubject<double> _progressSubject = BehaviorSubject.seeded(0);

  Stream<double> get progressStream => _progressSubject.stream;

  @override
  void dispose() {
    _progressSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        AppControlSwitch(
          label: 'Samsung AC',
          valueStream: Stream.value(true),
          onChanged: (value) {},
        ),
        Align(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CircularKnobView(
              context: context,
              progress: 10,
              progressText: '10',
              progressLabelText: 'Celcius',
            ),
          ),
        ),
        // AppControlCircularProgress(
        //   label: 'Temperature',
        //   valueStream: progressStream,
        //   onChanged: (value) {
        //     _progressSubject.add(value);
        //   },
        // ),
        const Gap(20),
        Align(
          child: SliderDialView(
            context: context,
            thumbRadius: 16,
            onChanged: (value) {},
          ),
        )
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
