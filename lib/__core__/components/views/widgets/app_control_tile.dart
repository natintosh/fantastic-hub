import 'package:arrow_pad/arrow_pad.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/components/styles/app_colors.dart';
import 'package:hub/__core__/components/views/widgets/app_rounded_container.dart';
import 'package:hub/__core__/components/views/widgets/circular_knob_view.dart';
import 'package:hub/__core__/components/views/widgets/color_picker_widget.dart';
import 'package:hub/__core__/components/views/widgets/media_control.dart';
import 'package:hub/__core__/components/views/widgets/slider_dial_view.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/theme.dart';
import 'package:hub/__core__/utils/math.dart';
import 'package:iconforest_icon_park/icon_park.dart';

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

class AppControlDirectionPad extends AppControlTile {
  const AppControlDirectionPad({super.key}) : super(label: '');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Gap(20),
        SizedBox(width: 200, height: 200, child: ArrowPad()),
        Gap(20),
      ],
    );
  }
}

class AppControlMedia extends AppControlTile {
  const AppControlMedia({super.key}) : super(label: '');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Gap(20),
        MediaControlView(),
        Gap(20),
      ],
    );
  }
}

class AppControlColorPicker extends AppControlTile {
  const AppControlColorPicker({
    super.key,
    required super.label,
    this.valueStream,
    this.onChanged,
  });

  final Stream<Color>? valueStream;
  final ValueChanged<Color>? onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Color>(
      stream: valueStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? Colors.white;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label.isNotEmpty)
              Text(
                label,
                style: context.theme.textTheme.titleLarge,
              ),
            const Gap(20),
            ColorPickerView(
              color: data,
              onChanged: onChanged,
            ),
            const Gap(20),
          ],
        );
      },
    );
  }
}

class AppControlSlider extends AppControlTile {
  const AppControlSlider({
    super.key,
    required super.label,
    this.valueStream,
    this.onChanged,
  });

  final Stream<double>? valueStream;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: valueStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? 0.0;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label.isNotEmpty)
              Text(
                label,
                style: context.theme.textTheme.titleLarge,
              ),
            const Gap(20),
            Align(
              child: SliderDialView(
                context: context,
                progress: data,
                onChanged: onChanged,
              ),
            )
          ],
        );
      },
    );
  }
}

@immutable
class DeviceMode {
  const DeviceMode(
      {required this.id, required this.label, required this.asset});

  final int id;
  final String label;
  final String asset;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceMode && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

enum TimerMode {
  automatic('Automatic'),
  reading('Reading'),
  timer('Timer');

  const TimerMode(this.label);

  final String label;
}

class TimerModeData {
  TimerModeData({
    this.mode = TimerMode.automatic,
    this.duration = 0,
  });

  final TimerMode mode;
  final double duration;

  TimerModeData copyWith({TimerMode? mode, double? duration}) {
    return TimerModeData(
      mode: mode ?? this.mode,
      duration: duration ?? this.duration,
    );
  }
}

class AppControlTimerSelector extends AppControlTile {
  const AppControlTimerSelector({
    super.key,
    required super.label,
    this.valueStream,
    this.onChanged,
  });

  final Stream<TimerModeData>? valueStream;

  final ValueChanged<TimerModeData>? onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TimerModeData>(
      stream: valueStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? TimerModeData();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label.isNotEmpty)
              Text(
                label,
                style: context.theme.textTheme.titleLarge,
              ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final mode in TimerMode.values)
                  AppRoundedContainer(
                    color: mode == data.mode
                        ? context.theme.colorScheme.surfaceElevation5
                        : context.theme.colorScheme.surfaceElevation1,
                    child: Material(
                      color: AppColors.transparent,
                      child: InkWell(
                        onTap: () => onChanged?.call(
                          data.copyWith(mode: mode),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          child: Center(
                            child: Text(
                              mode.label,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (data.mode == TimerMode.timer)
              Align(
                child: SliderDialView(
                  context: context,
                  progress: 0.5,
                  stepSuffix: 'H',
                  maxTrackValue: 12,
                  trackStep: 2,
                  onChanged: (value) => onChanged?.call(
                    data.copyWith(duration: value),
                  ),
                ),
              ),
            const Gap(20),
          ],
        );
      },
    );
  }
}

class AppControlModeSelector extends AppControlTile {
  const AppControlModeSelector({
    super.key,
    required super.label,
    this.modes = const [],
    this.valueStream,
    this.onChanged,
  }) : assert(modes.length < 5);

  final Stream<int>? valueStream;
  final List<DeviceMode> modes;
  final ValueChanged<DeviceMode>? onChanged;

  @override
  Widget build(BuildContext context) {
    final activeColor = Color.lerp(context.theme.colorScheme.primary,
        context.theme.colorScheme.primaryContainer, 0.5);
    final inactiveColor = Color.lerp(context.theme.colorScheme.surface,
        context.theme.colorScheme.onSurfaceVariant, 0.5);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: StreamBuilder<int>(
        stream: valueStream,
        builder: (context, snapshot) {
          final selectedIndex = snapshot.data ?? 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label.isNotEmpty)
                Text(
                  label,
                  style: context.theme.textTheme.titleLarge,
                ),
              const Gap(20),
              AppRoundedContainer(
                color: context.theme.colorScheme.surfaceElevation1,
                child: SizedBox(
                  height: 96,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (final mode in modes)
                        Material(
                          color: AppColors.transparent,
                          child: InkWell(
                            onTap: () => onChanged?.call(mode),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: IconPark.svgAsset(
                                      mode.asset,
                                      color: mode.id == selectedIndex
                                          ? activeColor
                                          : inactiveColor,
                                    ),
                                  ),
                                  const Gap(8),
                                  if (mode.label.isNotEmpty)
                                    Text(
                                      mode.label,
                                      style: context.theme.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: mode.id == selectedIndex
                                            ? activeColor
                                            : inactiveColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AppControlCircularProgress extends AppControlTile {
  const AppControlCircularProgress({
    super.key,
    super.label = 'Temperature',
    this.labelText = 'Celsius',
    this.valueStream,
    this.maxValue = 32,
    this.minValue = 16,
    this.onChanged,
  });

  final String labelText;
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
            if (label.isNotEmpty)
              Text(
                label,
                style: context.theme.textTheme.titleLarge,
              ),
            const Gap(20),
            Align(
              child: SizedBox(
                width: 200,
                height: 200,
                child: CircularKnobView(
                  progress: data,
                  progressText: '${value.round()}',
                  labelText: labelText,
                  onChanged: onChanged,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class AppControlSwitch extends AppControlTile {
  const AppControlSwitch({
    super.key,
    required super.label,
    this.valueStream,
    this.activeValue = 'On',
    this.inactiveValue = 'Off',
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
        },
      ),
    );
  }
}
