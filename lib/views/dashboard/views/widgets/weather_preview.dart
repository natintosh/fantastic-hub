import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/components/views/widgets/app_rounded_container.dart';
import 'package:hub/views/dashboard/views/widgets/weather_details.dart';
import 'package:hub/views/dashboard/views/widgets/weather_information_days.dart';
import 'package:hub/views/dashboard/views/widgets/weather_location_details.dart';
import 'package:hub/views/weather/data/weather.dart';

class WeatherPreview extends StatefulWidget {
  const WeatherPreview({super.key});

  @override
  State<WeatherPreview> createState() => _WeatherPreviewState();
}

class _WeatherPreviewState extends State<WeatherPreview> {
  final temperatureRange = 40;

  late final List<Weather> weatherInformation = List.generate(3, (index) {
    final temperature = -5 + Random().nextInt(temperatureRange);
    return Weather(
      city: 'Lagos',
      country: 'Nigeria',
      day: DateTime.now().add(Duration(days: index)),
      description: temperature < 14
          ? 'Snowy'
          : temperature < 24
              ? 'Rainy'
              : 'Sunny',
      temperature: temperature,
    );
  });

  late Weather selectedWeather = weatherInformation.first;

  void onWeatherDaySelected(Weather weather) {
    selectedWeather = weather;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppRoundedContainer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Flexible(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: WeatherInformation(
                    key: ValueKey(selectedWeather),
                    weather: selectedWeather,
                  ),
                ),
              ),
              WeatherInformationDays(
                upcomingDays: weatherInformation,
                onChanged: onWeatherDaySelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherInformation extends StatelessWidget {
  const WeatherInformation({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherLocationDetails(weather: weather),
        const Gap(20),
        WeatherDetails(weather: weather),
      ],
    );
  }
}
