import 'dart:math';
import 'dart:ui';


extension SizeX on Size {
  double get radius => min(width, height) / 2;
}

extension NumX<T extends num> on T {
  double get degrees => (this * 180.0) / pi;

  double get radians => (this * pi) / 180.0;

  T normalize(T max) => (this % max + max) % max as T;

  double get normalizeAngle => normalize(pi * 2.0 as T).toDouble();

  double subtractAngle(T diff) => (this - diff).normalizeAngle;

  double addAngle(T diff) => (this + diff).normalizeAngle;
}