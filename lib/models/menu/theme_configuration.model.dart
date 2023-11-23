import 'dart:ui';

import 'package:flutter_color/flutter_color.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:valiq_editor_demo/constants/theme_constants.dart';

part 'theme_configuration.model.g.dart';

@JsonSerializable()
class ThemeConfigurationModel {
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  Color brandColor; // accent color - 10%

  Brightness? brightness;

  String? code;

  String? titlesFont;
  String? bodyFont;

  ThemeConfigurationModel({
    required this.brandColor,
    this.code,
    this.brightness,
    this.titlesFont,
    this.bodyFont,
  });

  factory ThemeConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeConfigurationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeConfigurationModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeConfigurationModel &&
          runtimeType == other.runtimeType &&
          brandColor == other.brandColor &&
          code == other.code &&
          titlesFont == other.titlesFont &&
          bodyFont == other.bodyFont &&
          brightness == other.brightness;

  @override
  int get hashCode =>
      brandColor.hashCode ^ brightness.hashCode ^ code.hashCode ^ titlesFont.hashCode ^ bodyFont.hashCode;

  static ThemeConfigurationModel vali() => ThemeConfigurationModel(
        brandColor: kBrandColor,
        titlesFont: "Bebas Neue",
        bodyFont: "Mulish",
      );

  // copyWith
  ThemeConfigurationModel copyWith({
    Color? brandColor,
    Brightness? brightness,
    String? code,
    String? titlesFont,
    String? bodyFont,
  }) {
    return ThemeConfigurationModel(
      brandColor: brandColor ?? this.brandColor,
      brightness: brightness ?? this.brightness,
      code: code ?? this.code,
      titlesFont: titlesFont ?? this.titlesFont,
      bodyFont: bodyFont ?? this.bodyFont,
    );
  }

  // empty
  static ThemeConfigurationModel empty() => ThemeConfigurationModel(
        brandColor: kBrandColor,
        titlesFont: "Bebas Neue",
        bodyFont: "Mulish",
      );

  ThemeConfigurationModel resetBrightness() {
    return ThemeConfigurationModel(
        brandColor: brandColor, brightness: null, code: code, titlesFont: titlesFont, bodyFont: bodyFont);
  }

  ThemeConfigurationModel resetCode() {
    return ThemeConfigurationModel(
        brandColor: brandColor,
        brightness: brightness,
        code: null,
        titlesFont: titlesFont,
        bodyFont: bodyFont);
  }

  static Color _colorFromJson(String hex) => HexColor(hex);
  static String _colorToJson(Color color) => color.asHexString;
}
