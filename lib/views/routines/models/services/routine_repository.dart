import 'package:flutter/material.dart';
import 'package:hub/__core__/data/local/in_memory_cache.dart';
import 'package:hub/views/routines/models/data/routine.dart';

const List<Routine> mockRoutineData = [
  Routine(
    name: 'Good Morning',
    startTime: TimeOfDay(hour: 5, minute: 0),
    endTime: TimeOfDay(hour: 9, minute: 0),
    days: [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ],
  ),
  Routine(
    name: 'Good Night',
    startTime: TimeOfDay(hour: 20, minute: 0),
    endTime: TimeOfDay(hour: 23, minute: 59),
    days: [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ],
  ),
];

class RoutineRepository extends InMemoryCache<Routine> {
  RoutineRepository._();

  factory RoutineRepository.initMock() {
    return RoutineRepository._()..addAll(mockRoutineData);
  }
}
