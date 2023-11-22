import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.model.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(includeFromJson: true, includeToJson: false)
  String id;
  String name;
  String? description;
  String? image;

  int position;
  bool visible;

  DateTime? createdAt;
  DateTime? updatedAt;

  // used for runtime purposes
  @JsonKey(includeFromJson: false, includeToJson: false)
  PlatformFile? imageFile;

  CategoryModel({
    required this.id,
    required this.name,
    this.position = 1,
    this.visible = true,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = {
      ...snapshot.data()!,
      'id': snapshot.id,
    };
    return CategoryModel.fromJson(data);
  }

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  // mock data
  CategoryModel.mock()
      : id = faker.guid.guid(),
        name = faker.food.dish(),
        description = faker.lorem.sentence(),
        position = faker.randomGenerator.integer(10, min: 1),
        visible = faker.randomGenerator.boolean(),
        image = faker.image.image(keywords: ['food'], random: true);

  CategoryModel.empty()
      : id = "",
        name = "",
        position = 1,
        visible = false,
        description = "";

  // copy with
  CategoryModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    int? position,
    bool? visible,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      position: position ?? this.position,
      visible: visible ?? this.visible,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CategoryModel) return false;

    return id == other.id && name == other.name && description == other.description && image == other.image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode ^ image.hashCode;
}
