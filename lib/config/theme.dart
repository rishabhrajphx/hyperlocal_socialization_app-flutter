import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTheme {
  // Define custom colors
  static const Color primaryColor = Color(0xFF000000);
  static const Color secondaryColor = Color(0xFF1C1C1E);
  static const Color backgroundColor = Color(0xFFF2F2F7);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color borderColor = Color(0xFFE5E5EA);
  
  // Dark theme colors
  static const Color darkPrimaryColor = Color(0xFFFFFFFF);
  static const Color darkSecondaryColor = Color(0xFFE5E5EA);
  static const Color darkBackgroundColor = Color(0xFF1C1C1E);
  static const Color darkSurfaceColor = Color(0xFF2C2C2E);
  static const Color darkBorderColor = Color(0xFF38383A);

  // Shared text styles
  static const TextStyle _baseHeadline = TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 0.25,
  );

  static const TextStyle _baseBody = TextStyle(
    letterSpacing: 0.5,
  );

  // Light theme
  static ThemeData get light {
    return _baseTheme(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      backgroundColor: backgroundColor,
      surfaceColor: surfaceColor,
      borderColor: borderColor,
    );
  }

  // Dark theme
  static ThemeData get dark {
    return _baseTheme(
      brightness: Brightness.dark,
      primaryColor: darkPrimaryColor,
      secondaryColor: darkSecondaryColor,
      backgroundColor: darkBackgroundColor,
      surfaceColor: darkSurfaceColor,
      borderColor: darkBorderColor,
    );
  }

  // Base theme generator
  static ThemeData _baseTheme({
    required Brightness brightness,
    required Color primaryColor,
    required Color secondaryColor,
    required Color backgroundColor,
    required Color surfaceColor,
    required Color borderColor,
  }) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        error: Colors.red,
        onPrimary: isDark ? darkSurfaceColor : surfaceColor,
        onSecondary: isDark ? darkSurfaceColor : surfaceColor,
        onSurface: primaryColor,
        onBackground: primaryColor,
        onError: surfaceColor,
      ),
      
      textTheme: TextTheme(
        displayLarge: _baseHeadline.copyWith(
          fontSize: 34,
          color: primaryColor,
        ),
        displayMedium: _baseHeadline.copyWith(
          fontSize: 28,
          color: primaryColor,
        ),
        titleLarge: _baseHeadline.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        bodyLarge: _baseBody.copyWith(
          fontSize: 16,
          color: primaryColor,
        ),
      ).apply(
        bodyColor: primaryColor,
        displayColor: primaryColor,
      ),

      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor),
        ),
        color: surfaceColor,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: isDark ? darkSurfaceColor : surfaceColor,
          backgroundColor: primaryColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        indicatorColor: primaryColor.withOpacity(0.1),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return TextStyle(
              color: primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            );
          }
          return TextStyle(
            color: primaryColor.withOpacity(0.6),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          );
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(
              color: primaryColor,
              size: 24,
            );
          }
          return IconThemeData(
            color: primaryColor.withOpacity(0.6),
            size: 24,
          );
        }),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
    );
  }
} 