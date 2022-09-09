

import 'package:hub/__core__/components/base_view_model.dart';
import 'package:hub/__core__/dependency_injector.dart';
import 'package:hub/views/location/models/data/location.dart';
import 'package:hub/views/location/models/services/location_service.dart';
import 'package:rxdart/rxdart.dart';

class LocationViewModel extends BaseViewModel {
  LocationViewModel(
      {LocationService? locationService})
      : service = locationService ?? locator<LocationService>();

  late final LocationService service;

  final BehaviorSubject<List<Location>> _routinesSubject = BehaviorSubject();

  Stream<List<Location>> get routineStream => _routinesSubject.stream;

  void update() {
    _routinesSubject.add(service.getAllItems());
  }

  List<Location> getAllLocation() {
    update();
    return service.getAllItems();
  }

  void addLocation(Location location) {
    service.addLocation(location);
    update();
  }

  @override
  void dispose() {
    _routinesSubject.close();
    super.dispose();
  }}