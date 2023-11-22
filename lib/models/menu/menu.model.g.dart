// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuModel _$MenuModelFromJson(Map json) => MenuModel(
      id: json['id'] as String,
      entity: EntityModel.fromJson(
          Map<String, dynamic>.from(json['entity'] as Map)),
      theme: ThemeConfigurationModel.fromJson(
          Map<String, dynamic>.from(json['theme'] as Map)),
      qrCode: QRCodeConfigurationModel.fromJson(
          Map<String, dynamic>.from(json['qr_code'] as Map)),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MenuModelToJson(MenuModel instance) {
  final val = <String, dynamic>{
    'entity': instance.entity.toJson(),
    'theme': instance.theme.toJson(),
    'qr_code': instance.qrCode.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  return val;
}
