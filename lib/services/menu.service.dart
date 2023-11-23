import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/models/menu/entity.model.dart';
import 'package:valiq_editor_demo/models/menu/menu.model.dart';

class MenuService {
  final db = FirebaseFirestore.instance;
  final collectionName = 'menus';

  /// * [id] - The id of the menu document to fetch
  ///
  /// Fetch the menu document from firestore
  /// and return a stream of the menu document
  /// as a MenuModel object.
  Stream<MenuModel?> getMenuStream(String id) async* {
    logger.t("Fetching menu $id document from firestore");
    // get document by id
    db.collection('menus').doc(id).snapshots().map((snapshot) {
      // convert to MenuModel
      return MenuModel.fromSnapshot(snapshot);
    });
  }

  Future<MenuModel?> getMenu(String id, {bool fake = false}) async {
    logger.t("Fetching menu $id document from ${fake ? 'FAKER MOCK' : 'firestore'}}");
    if (fake) {
      // Simulate a 2 second delay then return a MenuModel mock object
      await Future.delayed(const Duration(seconds: 1));
      return MenuModel.mock();
    }
    // get document by id
    final doc = await db.collection('menus').doc(id).get();
    // convert to MenuModel
    // logger.d(doc.data());
    return MenuModel.fromSnapshot(doc);
  }

  Future<MenuModel> createMenu(MenuModel menu) async {
    logger.t("Creating menu ${menu.id} document in firestore");
    // create document
    final docRef = await db.collection('menus').add(menu.toJson());

    // fetch document
    final doc = await docRef.get();
    // convert to MenuModel
    return MenuModel.fromSnapshot(doc);
  }

  Future<void> updateMenuEntity(String menuId, EntityModel entity) async {
    logger.t("Updating menu entity for $menuId document in firestore");

    // handle uploading image if imageFile is not null
    // if (entity.logoFile != null) {
    //   entity.logo = await locator<StorageService>().uploadFile('menus/$menuId/entity/logo', entity.logoFile!);
    // }

    // if (entity.coverFile != null) {
    //   entity.cover =
    //       await locator<StorageService>().uploadFile('menus/$menuId/entity/cover', entity.coverFile!);
    // }

    // update document
    db.collection('menus').doc(menuId).update({
      'entity': entity.toJson(),
    });
  }
}
