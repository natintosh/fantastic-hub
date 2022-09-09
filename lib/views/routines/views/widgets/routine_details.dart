import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/utils/utils.dart';
import 'package:hub/views/routines/models/data/routine.dart';

class RoutineDetails extends StatelessWidget {
  const RoutineDetails({super.key, required this.routine});

  final Routine routine;

  @override
  Widget build(BuildContext context) {
    final String days = shortenDayList(routine.days);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            routine.name,
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
                routine.startTime?.format(context) ?? '',
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
                days,
                style: context.theme.textTheme.bodyLarge,
              )
            ],
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (routine.devices.isEmpty)
                Text(
                  'No Devices',
                  style: context.theme.textTheme.titleMedium,
                )
              else
                Text(
                  'x${routine.devices.length} Devices',
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
