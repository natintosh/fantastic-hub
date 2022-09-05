import 'package:flutter/material.dart';

extension ThemeX on ColorScheme {
  Color get surfaceElevation1 =>
      Color.alphaBlend(surfaceTint.withOpacity(0.05), surface);

  Color get surfaceElevation2 =>
      Color.alphaBlend(surfaceTint.withOpacity(0.08), surface);

  Color get surfaceElevation3 =>
      Color.alphaBlend(surfaceTint.withOpacity(0.11), surface);

  Color get surfaceElevation4 =>
      Color.alphaBlend(surfaceTint.withOpacity(0.12), surface);

  Color get surfaceElevation5 =>
      Color.alphaBlend(surfaceTint.withOpacity(0.14), surface);
}
