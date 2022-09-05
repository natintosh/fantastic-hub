import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/theme.dart';
import 'package:hub/__core__/views/ui/widgets/app_rounded_container.dart';
import 'package:hub/__core__/views/ui/widgets/enhanced_text.dart';

class WeatherLocationDetails extends StatelessWidget {
  const WeatherLocationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    return Row(
      children: [
        AppRoundedContainer(
          color: context.theme.colorScheme.surfaceElevation3,
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              FluentIcons.weather_partly_cloudy_day_24_filled,
            ),
          ),
        ),
        const Gap(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localization.weatherOutside),
            EnhancedText(
              text: 'Lagos, Nigeria',
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
