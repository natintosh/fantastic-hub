import 'package:hub/__core__/components/base_view_model.dart';
import 'package:hub/__core__/dependency_injector.dart';
import 'package:hub/views/devices/models/data/device.dart';
import 'package:hub/views/devices/models/services/device_service.dart';
import 'package:hub/views/routines/models/data/routine.dart';
import 'package:hub/views/routines/models/services/routine_service.dart';
import 'package:rxdart/rxdart.dart';

class RoutineViewModel extends BaseViewModel {
  RoutineViewModel(
      {RoutineService? routineService, DeviceService? deviceService})
      : service = routineService ?? locator<RoutineService>(),
        deviceService = deviceService ?? locator<DeviceService>();

  late final RoutineService service;
  late final DeviceService deviceService;

  final BehaviorSubject<List<Routine>> _routinesSubject = BehaviorSubject();

  Stream<List<Routine>> get routineStream => _routinesSubject.stream;

  void update() {
    _routinesSubject.add(service.getAllItems());
  }

  List<Routine> getAllRoutine() {
    update();
    return service.getAllItems();
  }

  void addRoutine(Routine routine) {
    service.addRoutine(routine);
    update();
  }

  void updateRoutine(Routine oldRoutine, Routine routine) {
    service.updateWhere((element) => element == oldRoutine, routine);
    update();
  }

  List<Device> getAllDevices() {
    return deviceService.getAllItems();
  }

  @override
  void dispose() {
    _routinesSubject.close();
    super.dispose();
  }
}
