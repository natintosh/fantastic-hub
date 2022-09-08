import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/components/views/widgets/app_rounded_container.dart';
import 'package:hub/views/details/models/data/device.dart';
import 'package:hub/views/statistics/view/widgets/bar_chart_view.dart';
import 'package:iconforest_icon_park/icon_park.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    final content = ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const Gap(20),
        const BarChartSample2(),
        const Gap(20),
        for (final deviceType in DeviceType.values)
          ListTile(
            title: Text(deviceType.name),
            subtitle:
                Text('${(100 * Random().nextDouble()).toStringAsFixed(2)} Kwh'),
            leading: SizedBox.square(
              dimension: 48,
              child: AppRoundedContainer(
                child: Center(
                    child: IconPark.svgAsset(deviceType.icon,
                        width: 24, height: 24)),
              ),
            ),
          )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistics"),
        centerTitle: true,
      ),
      body: content,
    );
  }
}
