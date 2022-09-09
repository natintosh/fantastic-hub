import 'package:hub/__core__/components/base_view_model.dart';
import 'package:hub/__core__/dependency_injector.dart';
import 'package:hub/views/devices/models/data/device.dart';
import 'package:hub/views/devices/models/services/device_service.dart';
import 'package:hub/views/location/models/data/location.dart';
import 'package:hub/views/location/models/services/location_service.dart';
import 'package:hub/views/routines/models/services/routine_service.dart';

class DashboardViewModel extends BaseViewModel {
  DashboardViewModel({DeviceService? deviceService,
    RoutineService? routineService,
    LocationService? locationService})
      : deviceService = deviceService ?? locator<DeviceService>(),
        routineService = routineService ?? locator<RoutineService>(),
        locationService = locationService ?? locator<LocationService>();

  final DeviceService deviceService;
  final RoutineService routineService;
  final LocationService locationService;


  Stream<List<Device>> getDevices() {
    return deviceService.getItems();
  }

  Stream<List<Location>> getLocations() {
    return locationService.getItems();
  }
}
