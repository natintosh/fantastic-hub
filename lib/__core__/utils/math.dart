import 'dart:math';
import 'dart:ui';

double toCartesian(Offset coords, double radius) {
  return (coords - Offset(radius, radius)).direction;
}

Offset toPolar(Offset center, double radians, double radius) {
  return center + Offset(radius * cos(radians), radius * sin(radians));
}

double Function(double input) interpolate({
  double inputMin = 0,
  double inputMax = 1,
  double outputMin = 0,
  double outputMax = 1,
}) {
  assert(inputMin != inputMax || outputMin != outputMax);

  final diff = (outputMax - outputMin) / (inputMax - inputMin);
  return (input) => ((input - inputMin) * diff) + outputMin;
}

