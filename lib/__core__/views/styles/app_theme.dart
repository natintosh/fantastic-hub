import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hub/__core__/views/styles/app_colors.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static ColorScheme get lightColorScheme => ColorScheme.fromSeed(
        seedColor: AppColors.seedColor,
      );

  static ColorScheme get darkColorScheme => ColorScheme.fromSeed(
        seedColor: AppColors.seedColor,
        brightness: Brightness.dark,
      );

  static ThemeData get lightTheme {
    final data = ThemeData.from(
      colorScheme: lightColorScheme,
      useMaterial3: true,
    );

    return _apply(data);
  }

  static ThemeData get darkTheme {
    final data = ThemeData.from(
      colorScheme: darkColorScheme,
      useMaterial3: true,
    );

    return _apply(data);
  }

  static ThemeData _apply(ThemeData data) {
    return data.copyWith(
      textTheme: GoogleFonts.ubuntuTextTheme(data.textTheme),
      primaryTextTheme: GoogleFonts.ubuntuTextTheme(data.primaryTextTheme),
      appBarTheme: data.appBarTheme.copyWith(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
        ),
      ),
    );
  }
}
