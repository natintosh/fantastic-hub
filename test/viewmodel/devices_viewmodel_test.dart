import 'package:flutter_test/flutter_test.dart';
import 'package:hub/views/devices/models/data/device.dart';
import 'package:hub/views/devices/models/services/device_repository.dart';
import 'package:hub/views/devices/models/services/device_service.dart';
import 'package:hub/views/devices/viewmodels/device_viewmodels.dart';
import 'package:hub/views/location/models/data/location.dart';
import 'package:hub/views/location/models/services/location_repository.dart';
import 'package:hub/views/location/models/services/location_service.dart';

void main() {
  final LocationRepository locationRepository = LocationRepository.initMock();
  late final LocationService locationService =
      LocationService(locationRepository);

  final DeviceRepository repository = DeviceRepository.initMock();
  late final DeviceService service = DeviceService(repository);

  const device = Device(
    name: 'Device Name',
    location: Location(id: 1, name: 'Location'),
    type: DeviceType.television,
  );

  DeviceViewModel viewModel = DeviceViewModel(
    deviceService: service,
    locationService: locationService,
  );

  setUp(() async {
    viewModel = DeviceViewModel(
      deviceService: service,
      locationService: locationService,
    );
  });

  group('Devices View Model Test', () {
    test('Test that we can get all location', () {
      final locations = viewModel.getLocation();
      expect(mockLocations, locations);
    });

    test('Test that we can add and get device', () {
      viewModel.addDevice(device);
      final devices = viewModel.getAllDevices();
      expect(device, devices.last);
    });

    test('Test that we update device', () {
      var devices = viewModel.getAllDevices();
      final data = devices.last;

      final editedData = data.copyWith(isActive: !data.isActive);
      viewModel.updateDevice(data, editedData);

      devices = viewModel.getAllDevices();
      expect(editedData, devices.last);
    });
  });
}
