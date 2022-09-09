import 'package:hub/__core__/data/local/in_memory_cache.dart';
import 'package:hub/views/location/models/data/location.dart';

const List<Location> mockLocations = [
  Location(id: 1, name: 'Living Room'),
  Location(id: 2, name: 'Kitchen'),
  Location(id: 3, name: 'Bedroom'),
  Location(id: 4, name: 'Office'),
];

class LocationRepository extends InMemoryCache<Location> {
  LocationRepository._();

  factory LocationRepository.initMock() {
    return LocationRepository._()..addAll(mockLocations);
  }
}
