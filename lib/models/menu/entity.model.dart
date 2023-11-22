import 'package:faker/faker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entity.model.g.dart';

@JsonSerializable()
class EntityModel {
  String name;
  String slogan;
  String logo;
  String currency;
  String cover;

  // used in runtime purposes only
  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  PlatformFile? logoFile;
  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  PlatformFile? coverFile;

  EntityModel({
    required this.name,
    required this.slogan,
    required this.logo,
    required this.cover,
    this.currency = "€",
  });

  factory EntityModel.fromJson(Map<String, dynamic> json) => _$EntityModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntityModelToJson(this);

  // copyWith
  EntityModel copyWith({
    String? name,
    String? slogan,
    String? logo,
    String? currency,
    String? cover,
  }) {
    return EntityModel(
      name: name ?? this.name,
      slogan: slogan ?? this.slogan,
      logo: logo ?? this.logo,
      currency: currency ?? this.currency,
      cover: cover ?? this.cover,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntityModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          slogan == other.slogan &&
          currency == other.currency &&
          logo == other.logo &&
          cover == other.cover;

  @override
  int get hashCode => name.hashCode ^ currency.hashCode ^ slogan.hashCode ^ logo.hashCode ^ cover.hashCode;

  static EntityModel mock() => EntityModel(
        name: faker.food.restaurant(),
        slogan: faker.lorem.sentence(),
        currency: faker.currency.code(),
        cover: faker.image.image(keywords: ['cover', 'food'], width: 360, height: 900),
        logo: faker.image.image(keywords: ['logo', 'food'], width: 200, height: 200),
      );

  // empty
  static EntityModel empty() => EntityModel(
        name: '',
        slogan: '',
        currency: 'EUR',
        cover: '',
        logo: '',
      );
}
