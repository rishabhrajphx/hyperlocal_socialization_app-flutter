class AppTheme {
  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: Colors.black,
        secondary: Colors.grey[900]!,
        surface: Colors.white,
        background: Colors.grey[50]!,
      ),
      // Apple-like components
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      // More Apple-style configurations...
    );
  }
} 