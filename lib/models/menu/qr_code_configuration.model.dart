import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qr_flutter/qr_flutter.dart';

part 'qr_code_configuration.model.g.dart';

enum QrGapLevel {
  none,
  low,
  medium,
  high,
}

enum QrCodeType {
  simple,
  logo,
}

@JsonSerializable()
class QRCodeConfigurationModel {
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  Color pixelsColors;

  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  Color emptyPixelsColor;

  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  Color cornersColor;

  QrDataModuleShape pixelsShape;
  QrEyeShape cornersShape;

  QrGapLevel gapLevel;

  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  Color backgroundColor;

  QrCodeType type;

  QRCodeConfigurationModel({
    required this.type,
    this.pixelsShape = QrDataModuleShape.square,
    this.cornersShape = QrEyeShape.square,
    this.pixelsColors = Colors.black,
    this.emptyPixelsColor = Colors.transparent,
    this.cornersColor = Colors.black,
    this.gapLevel = QrGapLevel.none,
    this.backgroundColor = Colors.transparent,
  });

  factory QRCodeConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$QRCodeConfigurationModelFromJson(json);

  Map<String, dynamic> toJson() => _$QRCodeConfigurationModelToJson(this);

  // moc
  QRCodeConfigurationModel.mock()
      : type = QrCodeType.values[faker.randomGenerator.integer(2)],
        pixelsShape = QrDataModuleShape.values[faker.randomGenerator.integer(2)],
        pixelsColors = Colors.black,
        emptyPixelsColor = Colors.white,
        cornersColor = Colors.black,
        cornersShape = QrEyeShape.values[faker.randomGenerator.integer(2)],
        gapLevel = QrGapLevel.values[faker.randomGenerator.integer(4)],
        backgroundColor = Colors.transparent;

  // copyWith
  QRCodeConfigurationModel copyWith({
    Color? pixelsColors,
    Color? emptyPixelsColor,
    Color? cornersColor,
    QrEyeShape? cornersShape,
    QrGapLevel? gapLevel,
    Color? backgroundColor,
    QrDataModuleShape? pixelsShape,
    QrCodeType? type,
  }) {
    return QRCodeConfigurationModel(
      pixelsColors: pixelsColors ?? this.pixelsColors,
      emptyPixelsColor: emptyPixelsColor ?? this.emptyPixelsColor,
      cornersColor: cornersColor ?? this.cornersColor,
      cornersShape: cornersShape ?? this.cornersShape,
      gapLevel: gapLevel ?? this.gapLevel,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      pixelsShape: pixelsShape ?? this.pixelsShape,
      type: type ?? this.type,
    );
  }

  // == operator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QRCodeConfigurationModel &&
          runtimeType == other.runtimeType &&
          pixelsColors == other.pixelsColors &&
          pixelsShape == other.pixelsShape &&
          emptyPixelsColor == other.emptyPixelsColor &&
          cornersColor == other.cornersColor &&
          cornersShape == other.cornersShape &&
          gapLevel == other.gapLevel &&
          backgroundColor == other.backgroundColor &&
          type == other.type;

  // hashCode
  @override
  int get hashCode =>
      pixelsColors.hashCode ^
      pixelsShape.hashCode ^
      emptyPixelsColor.hashCode ^
      cornersColor.hashCode ^
      cornersShape.hashCode ^
      gapLevel.hashCode ^
      backgroundColor.hashCode ^
      type.hashCode;

  static Color _colorFromJson(String hex) => HexColor(hex);
  static String _colorToJson(Color color) => color.asHexString;
}
