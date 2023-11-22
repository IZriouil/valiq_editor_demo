// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map json) => ItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      price: json['price'] as num,
      position: json['position'] as int? ?? 1,
      visible: json['visible'] as bool? ?? true,
      discount: json['discount'] as num?,
      rating: json['rating'] as num?,
      isFavorite: json['is_favorite'] as bool?,
      isPopular: json['is_popular'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  val['price'] = instance.price;
  writeNotNull('discount', instance.discount);
  writeNotNull('rating', instance.rating);
  writeNotNull('is_favorite', instance.isFavorite);
  writeNotNull('is_popular', instance.isPopular);
  val['position'] = instance.position;
  val['visible'] = instance.visible;
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  return val;
}
