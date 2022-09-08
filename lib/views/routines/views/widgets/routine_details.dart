import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';

class RoutineDetails extends StatelessWidget {
  const RoutineDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good morning',
            style: context.theme.textTheme.titleMedium,
          ),
          const Gap(16),
          const Divider(height: 1),
          const Gap(16),
          Row(
            children: [
              const Icon(FluentIcons.clock_24_regular),
              const Gap(16),
              Text(
                '05:30 AM',
                style: context.theme.textTheme.bodyLarge,
              )
            ],
          ),
          const Gap(8),
          Row(
            children: [
              const Icon(FluentIcons.calendar_day_24_regular),
              const Gap(16),
              Text(
                'Su, Mo, Tu, We, Th, Fr, Sa',
                style: context.theme.textTheme.bodyLarge,
              )
            ],
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'x3 Devices',
                style: context.theme.textTheme.titleMedium,
              ),
              const Gap(16),
              const Icon(FluentIcons.chevron_right_24_filled)
            ],
          ),
        ],
      ),
    );
  }
}
