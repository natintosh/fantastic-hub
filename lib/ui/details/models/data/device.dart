class Device {
  Device(
      {required this.deviceType, required this.brand, required this.location});

  final String deviceType;
  final String brand;
  final String location;

  Device copyWith({String? deviceName, String? brand, String? location}) {
    return Device(
        deviceType: deviceName ?? this.deviceType,
        brand: brand ?? this.brand,
        location: location ?? this.location);
  }
}
