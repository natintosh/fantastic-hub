import 'package:flutter/foundation.dart';
import 'package:hub/views/location/models/data/location.dart';
import 'package:iconforest_icon_park/icon_park.dart';

enum DeviceType {
  voiceAssistant(
    icon: IconPark.voice,
    name: 'Voice Assistant',
  ),
  television(
    icon: IconPark.tv,
    name: 'Television',
  ),
  bulb(
    icon: IconPark.light,
    name: 'Light',
  ),
  airConditioner(
    icon: IconPark.air_conditioning,
    name: 'Air Conditioner',
  );

  const DeviceType({required this.icon, required this.name});

  final String name;
  final String icon;
}

@immutable
class Device {
  const Device({
    required this.name,
    required this.location,
    required this.type,
    this.isActive = false,
  });

  final String name;
  final DeviceType type;
  final Location location;
  final bool isActive;

  Device copyWith({
    String? name,
    String? brand,
    Location? location,
    DeviceType? type,
  }) {
    return Device(
        name: name ?? this.name,
        location: location ?? this.location,
        type: type ?? this.type);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Device &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type &&
          location == other.location;

  @override
  int get hashCode => name.hashCode ^ type.hashCode ^ location.hashCode;
}
