import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/views/weather/data/weather.dart';
import 'package:intl/intl.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final day = DateFormat('EEE, MMM d').format(weather.day);
    final temperature = weather.temperature;
    final description = weather.description;

    return Row(
      children: [
        ClipOval(
          child: DecoratedBox(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: WeatherBg(
              weatherType: description == 'Snowy'
                  ? WeatherType.heavySnow
                  : description == 'Rainy'
                      ? WeatherType.heavyRainy
                      : WeatherType.sunny,
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
              day,
              style: context.theme.textTheme.bodySmall,
            ),
            Text(
              '$temperature° C',
              style: context.theme.textTheme.titleLarge,
            ),
            Text(
              description,
              style: context.theme.textTheme.bodyMedium,
            ),
          ],
        )
      ],
    );
  }
}
