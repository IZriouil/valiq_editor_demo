// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_configuration.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeConfigurationModel _$ThemeConfigurationModelFromJson(Map json) =>
    ThemeConfigurationModel(
      brandColor:
          ThemeConfigurationModel._colorFromJson(json['brand_color'] as String),
      code: json['code'] as String?,
      brightness: $enumDecodeNullable(_$BrightnessEnumMap, json['brightness']),
    );

Map<String, dynamic> _$ThemeConfigurationModelToJson(
    ThemeConfigurationModel instance) {
  final val = <String, dynamic>{
    'brand_color': ThemeConfigurationModel._colorToJson(instance.brandColor),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('brightness', _$BrightnessEnumMap[instance.brightness]);
  writeNotNull('code', instance.code);
  return val;
}

const _$BrightnessEnumMap = {
  Brightness.dark: 'dark',
  Brightness.light: 'light',
};
