import 'package:flutter/foundation.dart';

@immutable
class Location {
  Location({required this.id, required this.name});

  final int id;
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
