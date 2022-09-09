

import 'package:hub/views/devices/models/data/device.dart';
import 'package:hub/views/devices/models/services/device_repository.dart';

class DeviceService {
  DeviceService(this.repository);


  final DeviceRepository repository;


  void addLocation(Device item) {
    return repository.add(item);
  }

  void addAllLocation(List<Device> items) {
    return repository.addAll(items);
  }

  void deleteAll() {
    return repository.deleteAll();
  }

  void deleteWhere(bool Function(Device element) predicate) {
    return repository.deleteWhere((element) => false);
  }

  Device removeAt(int index) {
    return repository.removeAt(index);
  }

  bool updateWhere(
      bool Function(Device element) predicate, Device items) {
    return repository.updateWhere(predicate, items);
  }

  List<Device> getAllItems() {
    return repository.getAllItems();
  }
}
