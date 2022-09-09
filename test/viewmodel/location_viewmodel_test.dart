import 'package:flutter_test/flutter_test.dart';
import 'package:hub/views/location/location_viewmodel.dart';
import 'package:hub/views/location/models/data/location.dart';
import 'package:hub/views/location/models/services/location_repository.dart';
import 'package:hub/views/location/models/services/location_service.dart';

void main() {
  final LocationRepository repository = LocationRepository.initMock();

  late final LocationService service = LocationService(repository);

  LocationViewModel viewModel = LocationViewModel(locationService: service);

  const mockLocation1 = Location(id: 1, name: 'Home');
  const mockLocation2 = Location(id: 2, name: 'Kitchen');
  const mockLocation3 = Location(id: 2, name: 'Office');

  final mockData = [mockLocation1, mockLocation2];

  setUp(() async {
    viewModel = LocationViewModel(locationService: service);
  });

  group('Location View Model Test', () {
    test('Test that we can get all location', () {
      final locations = viewModel.getAllLocation();
      expect(mockLocations, locations);
    });

    test('Test that we add location', () {
      viewModel.addLocation(mockLocation3);
      final location = viewModel.getAllLocation().last;
      expect(mockLocation3, location);
    });
  });
}
