import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_cloud_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/theme.dart';
import 'package:hub/__core__/views/ui/widgets/app_rounded_container.dart';
import 'package:hub/ui/dashboard/views/widgets/weather_details.dart';
import 'package:hub/ui/dashboard/views/widgets/weather_information_days.dart';
import 'package:hub/ui/dashboard/views/widgets/weather_location_details.dart';

class WeatherPreview extends StatelessWidget {
  const WeatherPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppRoundedContainer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: const [
              Flexible(
                child: WeatherInformation(),
              ),
              WeatherInformationDays(),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherInformation extends StatelessWidget {
  const WeatherInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        WeatherLocationDetails(),
        Gap(20),
        WeatherDetails(),
      ],
    );
  }
}
