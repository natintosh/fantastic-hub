import 'package:hub/__core__/data/local/in_memory_cache.dart';
import 'package:hub/views/devices/models/data/device.dart';
import 'package:hub/views/location/models/data/location.dart';

class DeviceRepository extends InMemoryCache<Device> {
  DeviceRepository._();

  factory DeviceRepository.initMock() {
    final List<Device> mockData = [
      Device(
        name: 'Samsung TV',
        location: Location(id: 1, name: 'Living Room'),
        type: DeviceType.television,
      ),
      Device(
        name: 'Phillip Hue',
        location: Location(id: 1, name: 'Living Room'),
        type: DeviceType.bulb,
      ),
      Device(
        name: 'Amazon Echo',
        location: Location(id: 1, name: 'Living Room'),
        type: DeviceType.voiceAssistant,
      ),
      Device(
        name: 'Samsung AC',
        location: Location(id: 1, name: 'Living Room'),
        type: DeviceType.airConditioner,
      ),
      Device(
        name: 'Phillip Hue',
        location: Location(id: 2, name: 'Kitchen'),
        type: DeviceType.bulb,
      ),
      Device(
        name: 'Samsung TV',
        location: Location(id: 3, name: 'Bedroom'),
        type: DeviceType.television,
      ),
      Device(
        name: 'Phillip Hue',
        location: Location(id: 3, name: 'Bedroom'),
        type: DeviceType.bulb,
      ),
      Device(
        name: 'Amazon Echo',
        location: Location(id: 3, name: 'Bedroom'),
        type: DeviceType.voiceAssistant,
      ),
      Device(
        name: 'Samsung AC',
        location: Location(id: 3, name: 'Bedroom'),
        type: DeviceType.airConditioner,
      ),
      Device(
        name: 'Phillip Hue',
        location: Location(id: 4, name: 'Office'),
        type: DeviceType.bulb,
      ),
      Device(
        name: 'Samsung AC',
        location: Location(id: 4, name: 'Office'),
        type: DeviceType.airConditioner,
      ),
    ];

    return DeviceRepository._()..addAll(mockData);
  }
}
