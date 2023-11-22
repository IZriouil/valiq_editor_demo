import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:valiq_editor_demo/models/menu/qr_code_configuration.model.dart';

import 'entity.model.dart';
import 'theme_configuration.model.dart';

part 'menu.model.g.dart';

@JsonSerializable()
class MenuModel {
  @JsonKey(includeFromJson: true, includeToJson: false)
  String id;
  EntityModel entity;
  ThemeConfigurationModel theme;
  QRCodeConfigurationModel qrCode;

  DateTime? createdAt;
  DateTime? updatedAt;

  MenuModel({
    required this.id,
    required this.entity,
    required this.theme,
    required this.qrCode,
    this.createdAt,
    this.updatedAt,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => _$MenuModelFromJson(json);

  factory MenuModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = {
      ...snapshot.data()!,
      'id': snapshot.id,
    };
    return MenuModel.fromJson(data);
  }

  Map<String, dynamic> toJson() => _$MenuModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          entity == other.entity &&
          qrCode == other.qrCode &&
          theme == other.theme;

  @override
  int get hashCode => id.hashCode ^ entity.hashCode ^ theme.hashCode ^ qrCode.hashCode;

  // copy
  MenuModel copyWith({
    String? id,
    EntityModel? entity,
    String? currency,
    ThemeConfigurationModel? theme,
    QRCodeConfigurationModel? qrCode,
  }) {
    return MenuModel(
      id: id ?? this.id,
      entity: entity ?? this.entity,
      theme: theme ?? this.theme,
      qrCode: qrCode ?? this.qrCode,
    );
  }

  // empty
  static MenuModel empty() => MenuModel(
        id: '',
        entity: EntityModel.empty(),
        theme: ThemeConfigurationModel.vali(),
        qrCode: QRCodeConfigurationModel(
          type: QrCodeType.simple,
        ),
      );

  MenuModel.mock()
      : id = faker.guid.guid(),
        entity = EntityModel.mock(),
        qrCode = QRCodeConfigurationModel.mock(),
        theme = ThemeConfigurationModel.vali();
}
