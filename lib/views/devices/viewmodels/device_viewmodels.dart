import 'package:hub/__core__/components/base_view_model.dart';
import 'package:hub/__core__/dependency_injector.dart';
import 'package:hub/views/devices/models/data/device.dart';
import 'package:hub/views/devices/models/services/device_service.dart';
import 'package:hub/views/location/models/data/location.dart';
import 'package:hub/views/location/models/services/location_service.dart';

class DeviceViewModel extends BaseViewModel {
  DeviceViewModel({
    DeviceService? deviceService,
    LocationService? locationService,
  })  : service = deviceService ?? locator<DeviceService>(),
        locationService = locationService ?? locator<LocationService>();

  final DeviceService service;
  final LocationService locationService;


  List<Location> getLocation() {
    return locationService.getAllItems();
  }


  Stream<List<Device>> getDevices() {
    return service.getItems();
  }

  void addDevice(Device device) {
    service.addDevice(device);
  }


  void updateDevice(Device old, Device device) {
    service.updateWhere((element) => old == element, device);
  }

}
