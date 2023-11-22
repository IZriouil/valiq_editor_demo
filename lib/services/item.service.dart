import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/models/menu/category/item/item.model.dart';

class ItemService {
  final db = FirebaseFirestore.instance;

  /// * [menuId] is the id of the menu to which the item belongs
  /// * [categoryId] is the id of the category to which the item belongs
  ///
  /// fetches all items from the database
  /// and returns a [Stream] of [List<ItemModel>]
  Stream<List<ItemModel>> getItems(String menuId, String categoryId, {bool fake = false}) {
    logger.t("Fetching items for category $menuId/$categoryId from firestore");
    if (fake) {
      return Stream.fromFuture(Future.delayed(const Duration(seconds: 1)).then((value) {
        return List.generate(faker.randomGenerator.integer(10, min: 2), (index) {
          return ItemModel.mock();
        });
      }));
    }
    return db
        .collection("menus")
        .doc(menuId)
        .collection("categories")
        .doc(categoryId)
        .collection("items")
        .snapshots()
        .map<List<ItemModel>>((snapshot) => snapshot.docs.map((doc) => ItemModel.fromSnapshot(doc)).toList());
  }

  Future<ItemModel> addItem(String menuId, String categoryId, ItemModel newItem) async {
    logger.t("Adding item ${newItem.name} to firestore");

    // if (newItem.imageFile != null) {
    //   newItem.image = await locator<StorageService>()
    //       .uploadFile('menus/$menuId/categories/$categoryId/items/${newItem.id}', newItem.imageFile!);
    // }

    // add document to items collection
    return db
        .collection("menus")
        .doc(menuId)
        .collection("categories")
        .doc(categoryId)
        .collection("items")
        .add(newItem.toJson())
        .then((docRef) async {
      // get document by docRef;
      DocumentSnapshot<Map<String, dynamic>> doc = await docRef.get();
      return ItemModel.fromSnapshot(doc);
    });
  }

  Future<ItemModel> updateItem(String menuId, String categoryId, ItemModel updatedItem) async {
    logger.t("Updating item ${updatedItem.name} in firestore");

    // if (updatedItem.imageFile != null) {
    //   updatedItem.image = await locator<StorageService>()
    //       .uploadFile('menus/$menuId/categories/$categoryId/items/${updatedItem.id}', updatedItem.imageFile!);
    // }

    // update document in items collection
    return db
        .collection("menus")
        .doc(menuId)
        .collection("categories")
        .doc(categoryId)
        .collection("items")
        .doc(updatedItem.id)
        .update(updatedItem.toJson())
        .then((_) async {
      // get document by docRef;
      DocumentSnapshot<Map<String, dynamic>> doc = await db
          .collection("menus")
          .doc(menuId)
          .collection("categories")
          .doc(categoryId)
          .collection("items")
          .doc(updatedItem.id)
          .get();
      return ItemModel.fromSnapshot(doc);
    });
  }

  Future<void> updateItemPositions(String menuId, String categoryId, List<ItemModel> changedItems) async {
    logger.t("Updating items positions in firestore");

    WriteBatch batch = db.batch();

    for (ItemModel item in changedItems) {
      batch.update(
          db
              .collection("menus")
              .doc(menuId)
              .collection("categories")
              .doc(categoryId)
              .collection("items")
              .doc(item.id),
          {"position": item.position});
    }

    return batch.commit();
  }

  Future<void> deleteItem(String menuId, String categoryId, ItemModel item) async {
    logger.t("Deleting item ${item.name} from firestore");

    return db
        .collection("menus")
        .doc(menuId)
        .collection("categories")
        .doc(categoryId)
        .collection("items")
        .doc(item.id)
        .delete();
  }
}
