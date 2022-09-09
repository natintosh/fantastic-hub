import 'package:hub/views/location/models/data/location.dart';
import 'package:hub/views/location/models/services/location_repository.dart';

class LocationService {
  LocationService(this.repository);

  final LocationRepository repository;

  void addLocation(Location item) {
    return repository.add(item);
  }

  void addAllLocation(List<Location> items) {
    return repository.addAll(items);
  }

  void deleteAll() {
    return repository.deleteAll();
  }

  void deleteWhere(bool Function(Location element) predicate) {
    return repository.deleteWhere((element) => false);
  }

  Location removeAt(int index) {
    return repository.removeAt(index);
  }

  bool updateWhere(
      bool Function(Location element) predicate, Location item) {
    return repository.updateWhere(predicate, item);
  }

  List<Location> getAllItems() {
    return repository.getAllItems();
  }

  Stream<List<Location>> getItems() {
    return repository.getItems();
  }
}
