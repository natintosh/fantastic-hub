import 'package:flutter/foundation.dart';

@immutable
class Location {
  const Location({required this.id, required this.name});

  factory Location.empty() {
    return const Location(id: 0, name: '');
  }

  final int id;
  final String name;

  Location copyWith({int? id, String? name}) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

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
