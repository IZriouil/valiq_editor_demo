import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.model.g.dart';

@JsonSerializable()
class ItemModel {
  @JsonKey(includeFromJson: true, includeToJson: false)
  String id;
  String name;
  String? description;
  String? image;
  num price;
  num? discount;
  num? rating;
  // num? quantity;
  bool? isFavorite;
  bool? isPopular;

  int position;
  bool visible;

  DateTime? createdAt;
  DateTime? updatedAt;

  // for runtime purposes
  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  PlatformFile? imageFile;

  ItemModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.price,
    this.position = 1,
    this.visible = true,
    this.discount,
    this.rating,
    // this.quantity,
    this.isFavorite,
    this.isPopular,
    this.createdAt,
    this.updatedAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  factory ItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = {
      ...snapshot.data()!,
      'id': snapshot.id,
    };
    return ItemModel.fromJson(data);
  }

  // mock data
  ItemModel.mock()
      : id = faker.guid.guid(),
        name = faker.food.dish(),
        description = faker.lorem.sentence(),
        image = faker.image.image(keywords: ['food'], random: true),
        price = faker.randomGenerator.decimal(),
        discount = faker.randomGenerator.decimal(),
        rating = faker.randomGenerator.decimal(scale: 5),
        position = faker.randomGenerator.integer(10, min: 1),
        visible = faker.randomGenerator.boolean(),
        // quantity = 1,
        isFavorite = faker.randomGenerator.boolean(),
        isPopular = faker.randomGenerator.boolean();

  ItemModel.empty()
      : id = "",
        name = "",
        description = "",
        price = 0,
        discount = 0,
        position = 1,
        visible = true;

  // copy with
  ItemModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    num? price,
    num? discount,
    num? rating,
    int? position,
    bool? visible,
    // num? quantity,
    bool? isFavorite,
    bool? isPopular,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      rating: rating ?? this.rating,
      position: position ?? this.position,
      visible: visible ?? this.visible,
      // quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
      isPopular: isPopular ?? this.isPopular,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
