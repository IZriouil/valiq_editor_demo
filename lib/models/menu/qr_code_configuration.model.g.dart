// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_configuration.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRCodeConfigurationModel _$QRCodeConfigurationModelFromJson(Map json) =>
    QRCodeConfigurationModel(
      type: $enumDecode(_$QrCodeTypeEnumMap, json['type']),
      pixelsShape: $enumDecodeNullable(
              _$QrDataModuleShapeEnumMap, json['pixels_shape']) ??
          QrDataModuleShape.square,
      cornersShape:
          $enumDecodeNullable(_$QrEyeShapeEnumMap, json['corners_shape']) ??
              QrEyeShape.square,
      pixelsColors: json['pixels_colors'] == null
          ? Colors.black
          : QRCodeConfigurationModel._colorFromJson(
              json['pixels_colors'] as String),
      emptyPixelsColor: json['empty_pixels_color'] == null
          ? Colors.transparent
          : QRCodeConfigurationModel._colorFromJson(
              json['empty_pixels_color'] as String),
      cornersColor: json['corners_color'] == null
          ? Colors.black
          : QRCodeConfigurationModel._colorFromJson(
              json['corners_color'] as String),
      gapLevel: $enumDecodeNullable(_$QrGapLevelEnumMap, json['gap_level']) ??
          QrGapLevel.none,
      backgroundColor: json['background_color'] == null
          ? Colors.transparent
          : QRCodeConfigurationModel._colorFromJson(
              json['background_color'] as String),
    );

Map<String, dynamic> _$QRCodeConfigurationModelToJson(
        QRCodeConfigurationModel instance) =>
    <String, dynamic>{
      'pixels_colors':
          QRCodeConfigurationModel._colorToJson(instance.pixelsColors),
      'empty_pixels_color':
          QRCodeConfigurationModel._colorToJson(instance.emptyPixelsColor),
      'corners_color':
          QRCodeConfigurationModel._colorToJson(instance.cornersColor),
      'pixels_shape': _$QrDataModuleShapeEnumMap[instance.pixelsShape]!,
      'corners_shape': _$QrEyeShapeEnumMap[instance.cornersShape]!,
      'gap_level': _$QrGapLevelEnumMap[instance.gapLevel]!,
      'background_color':
          QRCodeConfigurationModel._colorToJson(instance.backgroundColor),
      'type': _$QrCodeTypeEnumMap[instance.type]!,
    };

const _$QrCodeTypeEnumMap = {
  QrCodeType.simple: 'simple',
  QrCodeType.logo: 'logo',
};

const _$QrDataModuleShapeEnumMap = {
  QrDataModuleShape.square: 'square',
  QrDataModuleShape.circle: 'circle',
};

const _$QrEyeShapeEnumMap = {
  QrEyeShape.square: 'square',
  QrEyeShape.circle: 'circle',
};

const _$QrGapLevelEnumMap = {
  QrGapLevel.none: 'none',
  QrGapLevel.low: 'low',
  QrGapLevel.medium: 'medium',
  QrGapLevel.high: 'high',
};
