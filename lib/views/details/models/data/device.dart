import 'package:iconforest_icon_park/icon_park.dart';

enum DeviceType {
  smartVoiceAssistant(
    icon: IconPark.voice,
    name: 'Voice Assistant',
  ),
  smartTelevision(
    icon: IconPark.tv,
    name: 'Television',
  ),
  smartBulb(
    icon: IconPark.light,
    name: 'Light',
  ),
  smartAirConditioner(
    icon: IconPark.air_conditioning,
    name: 'Air Conditioner',
  );

  const DeviceType({required this.icon, required this.name});

  final String name;
  final String icon;
}

class Device {
  Device({
    required this.name,
    required this.brand,
    required this.location,
    required this.type,
  });

  final String name;
  final String brand;
  final DeviceType type;
  final String location;

  Device copyWith(
      {String? name, String? brand, String? location, DeviceType? type}) {
    return Device(
        name: name ?? this.name,
        brand: brand ?? this.brand,
        location: location ?? this.location,
        type: type ?? this.type);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Device &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          brand == other.brand &&
          type == other.type &&
          location == other.location;

  @override
  int get hashCode =>
      name.hashCode ^ brand.hashCode ^ type.hashCode ^ location.hashCode;
}
