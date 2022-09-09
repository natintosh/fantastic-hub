


import 'package:hub/views/routines/models/data/routine.dart';
import 'package:hub/views/routines/models/services/routine_repository.dart';

class RoutineService {
  RoutineService(this.repository);


  final RoutineRepository repository;


  void addRoutine(Routine item) {
    return repository.add(item);
  }

  void addAllRoutine(List<Routine> items) {
    return repository.addAll(items);
  }

  void deleteAll() {
    return repository.deleteAll();
  }

  void deleteWhere(bool Function(Routine element) predicate) {
    return repository.deleteWhere((element) => false);
  }

  Routine removeAt(int index) {
    return repository.removeAt(index);
  }

  bool updateWhere(
      bool Function(Routine element) predicate, Routine items) {
    return repository.updateWhere(predicate, items);
  }

  List<Routine> getAllItems() {
    return repository.getAllItems();
  }
}