import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.model.g.dart';

@JsonSerializable()
class AccountModel {
  @JsonKey(includeFromJson: true, includeToJson: false)
  String id;
  String email;
  String? picture;
  List<String> menus;

  DateTime? createdAt;
  DateTime? updatedAt;

  AccountModel({
    required this.id,
    required this.email,
    required this.menus,
    this.picture,
    this.createdAt,
    this.updatedAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);

  factory AccountModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = {
      ...snapshot.data()!,
      'id': snapshot.id,
    };
    return AccountModel.fromJson(data);
  }

  AccountModel.mock()
      : id = faker.guid.guid(),
        email = faker.internet.email(),
        picture = faker.image.image(),
        menus = [
          faker.guid.guid(),
          faker.guid.guid(),
          faker.guid.guid(),
        ];
}
