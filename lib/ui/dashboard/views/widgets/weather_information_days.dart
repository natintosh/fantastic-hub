import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/theme.dart';
import 'package:hub/__core__/views/ui/widgets/app_rounded_container.dart';

class WeatherInformationDays extends StatelessWidget {
  const WeatherInformationDays({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox.square(
          dimension: 48,
          child: AppRoundedContainer(
            color: context.theme.colorScheme.surfaceElevation5,
            child: Text(
              'S',
              textAlign: TextAlign.center,
              style: context.theme.textTheme.titleLarge,
            ),
          ),
        ),
        const Gap(8),
        SizedBox.square(
          dimension: 48,
          child: AppRoundedContainer(
            color: context.theme.colorScheme.surfaceElevation2,
            child: Text(
              'M',
              textAlign: TextAlign.center,
              style: context.theme.textTheme.titleLarge,
            ),
          ),
        ),
        const Gap(8),
        SizedBox.square(
          dimension: 48,
          child: AppRoundedContainer(
            color: context.theme.colorScheme.surfaceElevation2,
            child: Text(
              'T',
              textAlign: TextAlign.center,
              style: context.theme.textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}
