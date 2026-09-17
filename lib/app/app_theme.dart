import 'package:flutter/material.dart';
import 'app_colors.dart';


class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.light);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme(
        brightness: brightness,
        primary: AppColors.primary,
        onPrimary: AppColors.navy,
        secondary: AppColors.navy,
        onSecondary: AppColors.white,
        error: AppColors.danger,
        onError: AppColors.white,
        surface: isDark ? AppColors.darkSurface: AppColors.white,
        onSurface: isDark? AppColors.white: AppColors.primaryText);

    return ThemeData(
        useMaterial3: true,
        brightness: brightness,
        colorScheme: scheme,
        scaffoldBackgroundColor: isDark ? AppColors.darkBackground : Colors.white,
        dividerColor: isDark ? AppColors.boxShadow : AppColors.gray,
        appBarTheme: AppBarTheme(
        ));

  }
}