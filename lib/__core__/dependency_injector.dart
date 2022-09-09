import 'package:get_it/get_it.dart';
import 'package:hub/views/devices/models/services/device_repository.dart';
import 'package:hub/views/devices/models/services/device_service.dart';
import 'package:hub/views/location/models/services/location_repository.dart';
import 'package:hub/views/location/models/services/location_service.dart';
import 'package:hub/views/routines/models/services/routine_repository.dart';
import 'package:hub/views/routines/models/services/routine_service.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator
    ..registerSingletonAsync<LocationService>(
      () async => LocationService(LocationRepository.initMock()),
    )
    ..registerSingletonAsync<DeviceService>(
      () async => DeviceService(DeviceRepository.initMock()),
    )
    ..registerSingletonAsync<RoutineService>(
      () async => RoutineService(RoutineRepository.initMock()),
    );
}
