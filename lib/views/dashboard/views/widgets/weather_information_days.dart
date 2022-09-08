import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/theme.dart';
import 'package:hub/__core__/components/styles/app_colors.dart';
import 'package:hub/__core__/components/views/widgets/app_rounded_container.dart';
import 'package:hub/views/weather/data/weather.dart';
import 'package:intl/intl.dart';

class WeatherInformationDays extends StatelessWidget {
  const WeatherInformationDays(
      {super.key, required this.onChanged, required this.upcomingDays});

  final List<Weather> upcomingDays;

  final ValueChanged<Weather> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final weather in upcomingDays)
          Column(
            children: [
              AppRoundedContainer(
                color: context.theme.colorScheme.surfaceElevation5,
                child: SizedBox.square(
                  dimension: 48,
                  child: Material(
                    color: AppColors.transparent,
                    child: InkWell(
                      onTap: () => onChanged.call(weather),
                      child: Center(
                        child: Text(
                          DateFormat('EE').format(weather.day),
                          textAlign: TextAlign.center,
                          style: context.theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(8),
            ],
          ),
      ],
    );
  }
}
