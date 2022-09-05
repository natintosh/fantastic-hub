import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: DecoratedBox(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: WeatherBg(
              weatherType: WeatherType.sunny,
              width: 72,
              height: 72,
            ),
          ),
        ),
        const Gap(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thur, Jun 30',
              style: context.theme.textTheme.bodySmall,
            ),
            Text(
              '27° C',
              style: context.theme.textTheme.titleLarge,
            ),
            Text(
              'Sunny',
              style: context.theme.textTheme.bodyMedium,
            ),
          ],
        )
      ],
    );
  }
}
