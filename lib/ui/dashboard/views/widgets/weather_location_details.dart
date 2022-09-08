import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/theme.dart';
import 'package:hub/__core__/views/ui/widgets/app_rounded_container.dart';
import 'package:hub/__core__/views/ui/widgets/enhanced_text.dart';
import 'package:hub/ui/weather/data/weather.dart';

class WeatherLocationDetails extends StatelessWidget {
  const WeatherLocationDetails({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;

    final country = weather.country;
    final city = weather.city;
    final description = weather.description;

    return Row(
      children: [
        AppRoundedContainer(
          color: context.theme.colorScheme.surfaceElevation3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(
              description == 'Snowy'
                  ? FluentIcons.weather_snowflake_24_filled
                  : description == 'Rainy'
                      ? FluentIcons.weather_rain_24_filled
                      : FluentIcons.weather_partly_cloudy_day_24_filled,
            ),
          ),
        ),
        const Gap(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localization.weatherOutside),
            EnhancedText(
              text: '$city, $country',
              textStyle: context.theme.textTheme.bodySmall,
              prefix: Icon(
                FluentIcons.location_12_regular,
                size: 12,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
          ],
        )
      ],
    );
  }
}
