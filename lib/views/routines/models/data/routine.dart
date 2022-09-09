import 'package:flutter/material.dart';
import 'package:hub/views/devices/models/data/device.dart';

@immutable
class Routine {
  const Routine(
      {required this.name,
      required this.startTime,
      required this.endTime,
      this.days = const [],
      this.devices = const []});

  factory Routine.empty() {
    return const Routine(
      name: '',
      startTime: TimeOfDay(hour: 0, minute: 0),
      endTime: TimeOfDay(hour: 0, minute: 0),
    );
  }

  final String name;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final List<String> days;
  final List<Device> devices;

  Routine copyWith({
    String? name,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    List<String>? days,
    List<Device>? devices,
  }) {
    return Routine(
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      days: days ?? this.days,
      devices: devices ?? this.devices,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Routine &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          days == other.days &&
          devices == other.devices;

  @override
  int get hashCode =>
      name.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      days.hashCode ^
      devices.hashCode;
}
