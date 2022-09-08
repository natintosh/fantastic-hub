import 'package:flutter/material.dart';

@immutable
class Weather {
  const Weather({
    required this.city,
    required this.country,
    required this.day,
    required this.description,
    required this.temperature,
  });

  final String city;
  final String country;
  final DateTime day;

  final String description;
  final int temperature;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Weather &&
          runtimeType == other.runtimeType &&
          city == other.city &&
          country == other.country &&
          day == other.day &&
          description == other.description &&
          temperature == other.temperature;

  @override
  int get hashCode =>
      city.hashCode ^
      country.hashCode ^
      day.hashCode ^
      description.hashCode ^
      temperature.hashCode;
}
