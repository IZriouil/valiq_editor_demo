// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntityModel _$EntityModelFromJson(Map json) => EntityModel(
      name: json['name'] as String,
      slogan: json['slogan'] as String,
      logo: json['logo'] as String,
      cover: json['cover'] as String,
      currency: json['currency'] as String? ?? "€",
    );

Map<String, dynamic> _$EntityModelToJson(EntityModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slogan': instance.slogan,
      'logo': instance.logo,
      'currency': instance.currency,
      'cover': instance.cover,
    };
