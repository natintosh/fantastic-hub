import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/utils/math.dart';
import 'package:hub/__core__/views/ui/widgets/circular_knob_view.dart';

abstract class AppControlTile extends StatelessWidget {
  const AppControlTile({
    super.key,
    required this.label,
    this.child = const SizedBox.shrink(),
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context);
}

class AppControlCircularProgress extends AppControlTile {
  const AppControlCircularProgress({
    super.key,
    required super.label,
    this.valueStream,
    this.maxValue = 32,
    this.minValue = 16,
    this.onChanged,
  });

  final double maxValue;
  final double minValue;
  final Stream<double>? valueStream;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        stream: valueStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? 0;
          final value =
              interpolate(outputMin: minValue, outputMax: maxValue)(data);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.theme.textTheme.titleLarge,
              ),
              const Gap(20),
              Align(
                child: CircularKnobView(
                  context: context,
                  progress: data,
                  progressText: '${value.round()}',
                  progressLabelText: 'Celcius',
                  onChanged: onChanged,
                ),
              )
            ],
          );
        });
  }
}

class AppControlSwitch extends AppControlTile {
  const AppControlSwitch({
    super.key,
    required super.label,
    this.valueStream,
    this.activeValue = 'Connected',
    this.inactiveValue = 'Not connected',
    this.onChanged,
  });

  final Stream<bool>? valueStream;
  final String activeValue;
  final String inactiveValue;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: StreamBuilder<bool>(
          stream: valueStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? false;
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: context.theme.textTheme.titleLarge,
                      ),
                      Text(
                        data ? activeValue : inactiveValue,
                        style: context.theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: data,
                  onChanged: onChanged,
                ),
              ],
            );
          }),
    );
  }
}
