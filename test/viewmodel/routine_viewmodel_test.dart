import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hub/views/devices/models/services/device_repository.dart';
import 'package:hub/views/devices/models/services/device_service.dart';
import 'package:hub/views/routines/models/data/routine.dart';
import 'package:hub/views/routines/models/services/routine_repository.dart';
import 'package:hub/views/routines/models/services/routine_service.dart';
import 'package:hub/views/routines/viewmodels/routine_viewmodel.dart';

void main() {
  final DeviceRepository deviceRepository = DeviceRepository.initMock();
  late final DeviceService deviceService = DeviceService(deviceRepository);

  final RoutineRepository repository = RoutineRepository.initMock();
  late final RoutineService service = RoutineService(repository);

  const routine = Routine(
    name: 'Good Night',
    startTime: TimeOfDay(hour: 20, minute: 0),
    endTime: TimeOfDay(hour: 23, minute: 59),
    days: ['Sunday', 'Saturday'],
  );

  RoutineViewModel viewModel = RoutineViewModel(
    routineService: service,
    deviceService: deviceService,
  );

  setUp(() async {
    viewModel = RoutineViewModel(
      routineService: service,
      deviceService: deviceService,
    );
  });

  group('Devices View Model Test', () {
    test('Test that we can get all devices', () {
      final routine = viewModel.getAllRoutine();
      expect(mockRoutineData, routine);
    });

    test('Test that we can get all devices', () {
      final devices = viewModel.getAllDevices();
      expect(devicesMockData, devices);
    });

    test('Test that we can add and get routine', () {
      final routine = viewModel.getAllRoutine().last;
      final updatedRoutine = routine.copyWith(name: 'Lorem');
      viewModel.updateRoutine(routine, updatedRoutine);
      final routines = viewModel.getAllRoutine();
      expect(updatedRoutine, routines.last);
    });
  });
}
