import 'package:flutter/material.dart';

/// Centralized design tokens extracted directly from DESIGN.md
abstract class AppColors {
  static const Color surface = Color(0xFF131313);
  static const Color surfaceDim = Color(0xFF131313);
  static const Color surfaceBright = Color(0xFF393939);
  static const Color surfaceContainerLowest = Color(0xFF0E0E0E);
  static const Color surfaceContainerLow = Color(0xFF1C1B1B);
  static const Color surfaceContainer = Color(0xFF201F1F);
  static const Color surfaceContainerHigh = Color(0xFF2A2A2A);
  static const Color surfaceContainerHighest = Color(0xFF353534);
  static const Color onSurface = Color(0xFFE5E2E1);
  static const Color onSurfaceVariant = Color(0xFFD0C5AF);
  static const Color inverseSurface = Color(0xFFE5E2E1);
  static const Color inverseOnSurface = Color(0xFF313030);
  static const Color outline = Color(0xFF99907C);
  static const Color outlineVariant = Color(0xFF4D4635);
  static const Color surfaceTint = Color(0xFFE9C349);
  static const Color primary = Color(0xFFF2CA50);
  static const Color onPrimary = Color(0xFF3C2F00);
  static const Color primaryContainer = Color(0xFFD4AF37);
  static const Color onPrimaryContainer = Color(0xFF554300);
  static const Color inversePrimary = Color(0xFF735C00);
  static const Color secondary = Color(0xFFADC7FF);
  static const Color onSecondary = Color(0xFF002E68);
  static const Color secondaryContainer = Color(0xFF4A8EFF);
  static const Color onSecondaryContainer = Color(0xFF00285B);
  static const Color tertiary = Color(0xFFD0CDCD);
  static const Color onTertiary = Color(0xFF303030);
  static const Color tertiaryContainer = Color(0xFFB4B2B2);
  static const Color onTertiaryContainer = Color(0xFF454544);
  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);
  static const Color primaryFixed = Color(0xFFFFE088);
  static const Color primaryFixedDim = Color(0xFFE9C349);
  static const Color onPrimaryFixed = Color(0xFF241A00);
  static const Color onPrimaryFixedVariant = Color(0xFF574500);
  static const Color secondaryFixed = Color(0xFFD8E2FF);
  static const Color secondaryFixedDim = Color(0xFFADC7FF);
  static const Color onSecondaryFixed = Color(0xFF001A41);
  static const Color onSecondaryFixedVariant = Color(0xFF004493);
  static const Color tertiaryFixed = Color(0xFFE5E2E1);
  static const Color tertiaryFixedDim = Color(0xFFC8C6C5);
  static const Color onTertiaryFixed = Color(0xFF1B1B1C);
  static const Color onTertiaryFixedVariant = Color(0xFF474746);
  static const Color background = Color(0xFF131313);
  static const Color onBackground = Color(0xFFE5E2E1);
  static const Color surfaceVariant = Color(0xFF353534);

  // Border semi-transparent slate grey per DESIGN.md accents
  static final Color borderSubtle = Colors.white.withValues(alpha: 0.08);
  static final Color borderLevel1 = Colors.white.withValues(alpha: 0.05);
}

abstract class AppRadius {
  static const double sm = 2.0;
  static const double defaultRadius = 4.0;
  static const double md = 6.0;
  static const double lg = 8.0;
  static const double xl = 12.0;
  static const double full = 9999.0;
}

abstract class AppSpacing {
  static const double containerMargin = 20.0;
  static const double stackGap = 16.0;
  static const double elementPadding = 12.0;
  static const double sectionPadding = 32.0;
}

abstract class AppTypography {
  static const TextStyle displayLg = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    height: 40.0 / 32.0,
    letterSpacing: -0.64,
    color: AppColors.onSurface,
  );

  static const TextStyle headlineMd = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    height: 32.0 / 24.0,
    letterSpacing: -0.24,
    color: AppColors.onSurface,
  );

  static const TextStyle headlineSm = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    height: 28.0 / 20.0,
    color: AppColors.onSurface,
  );

  static const TextStyle bodyLg = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    height: 24.0 / 16.0,
    color: AppColors.onSurface,
  );

  static const TextStyle bodyMd = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 20.0 / 14.0,
    color: AppColors.onSurface,
  );

  static const TextStyle labelMd = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 16.0 / 12.0,
    letterSpacing: 0.6,
    color: AppColors.onSurfaceVariant,
  );

  static const TextStyle labelSm = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
    height: 14.0 / 11.0,
    color: AppColors.onSurfaceVariant,
  );
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        error: AppColors.error,
        onError: AppColors.onError,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
    );
  }
}
