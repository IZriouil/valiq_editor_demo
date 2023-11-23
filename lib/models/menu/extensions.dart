import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valiq_editor_demo/models/menu/qr_code_configuration.model.dart';

import 'entity.model.dart';
import 'menu.model.dart';
import 'theme_configuration.model.dart';

// Entity Extension
extension EntityExtension on EntityModel {
  ImageProvider get imgLogoProvider {
    return NetworkImage(
      logo,
    );
  }

  ImageProvider get imgCoverProvider {
    return NetworkImage(cover);
  }
}

// ThemeConfiguration Extension
extension ThemeConfigurationExtension on ThemeConfigurationModel {
  Brightness get calculatedBrightness => brightness ?? window.platformBrightness;
  // Brightness get calculatedBrightness => Brightness.dark;

  Color get generatedBackgroundColor {
    // check brightness
    Brightness bright = calculatedBrightness;

    switch (bright) {
      case Brightness.dark:
        return HSLColor.fromColor(brandColor).withLightness(0.02).withSaturation(0.09).toColor();

      case Brightness.light:
        return HSLColor.fromColor(brandColor).withLightness(0.98).withSaturation(0.09).toColor();
    }
  }

  Color get generatedTextColor {
    // check brightness
    Brightness bright = calculatedBrightness;

    switch (bright) {
      case Brightness.dark:
        return HSLColor.fromColor(brandColor).withLightness(0.98).withSaturation(0.02).toColor();

      case Brightness.light:
        return HSLColor.fromColor(brandColor).withLightness(0.02).withSaturation(0.93).toColor();
    }
  }

  Color get generatedBackgroundVariantColor {
    // check brightness
    Brightness bright = calculatedBrightness;

    switch (bright) {
      case Brightness.dark:
        return HSLColor.fromColor(brandColor).withLightness(0.16).withSaturation(0.03).toColor();

      case Brightness.light:
        return HSLColor.fromColor(brandColor).withLightness(0.95).withSaturation(0.03).toColor();
    }
  }

  ThemeData get data {
    ColorScheme scheme =
        (calculatedBrightness == Brightness.light ? const ColorScheme.light() : const ColorScheme.dark());

    Color backgroundColor = generatedBackgroundColor;
    Color textColor = generatedTextColor;
    Color backgroundVariantColor = generatedBackgroundVariantColor;

    return ThemeData(
        textTheme: TextTheme(
          displayLarge: GoogleFonts.getFont(titlesFont!,
              fontSize: 73, fontWeight: FontWeight.w300, letterSpacing: -1.5, color: textColor),
          displayMedium: GoogleFonts.getFont(
            titlesFont!,
            fontSize: 46,
            fontWeight: FontWeight.w300,
            letterSpacing: -0.5,
            color: textColor,
          ),
          displaySmall:
              GoogleFonts.getFont(titlesFont!, fontSize: 36, fontWeight: FontWeight.w400, color: textColor),
          headlineLarge: GoogleFonts.getFont(
            titlesFont!,
            fontSize: 32,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          headlineMedium: GoogleFonts.getFont(
            titlesFont!,
            fontSize: 26,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
            color: textColor,
          ),
          headlineSmall:
              GoogleFonts.getFont(titlesFont!, fontSize: 22, fontWeight: FontWeight.w400, color: textColor),
          titleLarge:
              GoogleFonts.getFont(titlesFont!, fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
          titleMedium:
              GoogleFonts.getFont(bodyFont!, fontSize: 16, fontWeight: FontWeight.w700, color: textColor),
          titleSmall:
              GoogleFonts.getFont(bodyFont!, fontSize: 14, fontWeight: FontWeight.w500, color: textColor),
          bodyLarge:
              GoogleFonts.getFont(bodyFont!, fontSize: 17, fontWeight: FontWeight.w400, color: textColor),
          bodyMedium:
              GoogleFonts.getFont(bodyFont!, fontSize: 15, fontWeight: FontWeight.w400, color: textColor),
          labelLarge:
              GoogleFonts.getFont(bodyFont!, fontSize: 15, fontWeight: FontWeight.w700, color: textColor),
          bodySmall:
              GoogleFonts.getFont(bodyFont!, fontSize: 13, fontWeight: FontWeight.w400, color: textColor),
          labelSmall:
              GoogleFonts.getFont(bodyFont!, fontSize: 11, fontWeight: FontWeight.w400, color: textColor),
        ),
        colorScheme: scheme.copyWith(
          primary: brandColor,
          secondary: backgroundVariantColor,
          onSecondary: textColor,
          onPrimary: textColor,
          background: backgroundColor,
          surface: backgroundColor,
          surfaceVariant: backgroundVariantColor,
          onBackground: textColor,
          onSurface: textColor,
          onSurfaceVariant: textColor,
        ));
  }
}

// Qr code extension
extension QrCodeExtension on QrGapLevel {
  double getSize() {
    switch (this) {
      case QrGapLevel.low:
        return 2;
      case QrGapLevel.medium:
        return 3;
      case QrGapLevel.high:
        return 4;
      default:
        return 0;
    }
  }
}

// Menu Extension
extension MenuExtension on MenuModel {}
