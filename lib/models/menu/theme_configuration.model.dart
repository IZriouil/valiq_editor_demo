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

  ThemeConfigurationModel({
    required this.brandColor,
    this.code,
    this.brightness,
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
          brightness == other.brightness;

  @override
  int get hashCode => brandColor.hashCode ^ brightness.hashCode ^ code.hashCode;

  static ThemeConfigurationModel vali() => ThemeConfigurationModel(
        brandColor: kBrandColor,
      );

  // copyWith
  ThemeConfigurationModel copyWith({
    Color? brandColor,
    Brightness? brightness,
    String? code,
  }) {
    return ThemeConfigurationModel(
      brandColor: brandColor ?? this.brandColor,
      brightness: brightness ?? this.brightness,
      code: code ?? this.code,
    );
  }

  // empty
  static ThemeConfigurationModel empty() => ThemeConfigurationModel(
        brandColor: kBrandColor,
      );

  ThemeConfigurationModel resetBrightness() {
    return ThemeConfigurationModel(brandColor: brandColor, brightness: null);
  }

  ThemeConfigurationModel resetCode() {
    return ThemeConfigurationModel(brandColor: brandColor, brightness: brightness, code: null);
  }

  static Color _colorFromJson(String hex) => HexColor(hex);
  static String _colorToJson(Color color) => color.asHexString;
}
