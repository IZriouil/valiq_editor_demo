import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'theme.model.g.dart';

@JsonSerializable()
class ValiqThemeModel {
  String id;
  String name;
  String description;
  String image;

  ValiqThemeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory ValiqThemeModel.fromJson(Map<String, dynamic> json) => _$ValiqThemeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ValiqThemeModelToJson(this);

  ValiqThemeModel.mock()
      : id = faker.guid.guid(),
        name = faker.company.name(),
        description = faker.lorem.sentences(faker.randomGenerator.integer(5, min: 2)).join(", "),
        image = faker.image.image(random: true, keywords: ["phone", "mobile", "device", "theme"]);
}
