import 'package:faker/faker.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/models/menu/category/category.model.dart';

class CategoryService {
  // final db = FirebaseFirestore.instance;

  /// * [menuId] is the id of the menu document
  ///
  /// Fetch the categories collection from firestore
  /// and return a stream of the categories collection
  /// as a List<CategoryModel> object.
  Stream<List<CategoryModel>> getCategories(String menuId, {bool fake = false}) {
    logger.t("Fetching categories $menuId collection from ${fake ? 'FAKER MOCK' : 'firestore'}}");
    // get collection by menuId

    // Simulate a 2 second delay then return a List<CategoryModel> mock object
    return Stream.fromFuture(Future.delayed(const Duration(seconds: 1)).then((value) {
      return List.generate(faker.randomGenerator.integer(15, min: 5), (index) {
        return CategoryModel.mock();
      });
    }));

    // return db
    //     .collection('menus')
    //     .doc(menuId)
    //     .collection('categories')
    //     .snapshots()
    //     .map<List<CategoryModel>>((snapshot) {
    //   // convert to List<CategoryModel>
    //   return snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
    // });
  }

  Future<CategoryModel> getCategory(String menuId, String categoryId) async {
    logger.t("Fetching category $categoryId from firestore");
    // get document by categoryId
    // DocumentSnapshot<Map<String, dynamic>> doc =
    //     await db.collection('menus').doc(menuId).collection('categories').doc(categoryId).get();
    // return CategoryModel.fromSnapshot(doc);
    return CategoryModel.mock();
  }

  Future<CategoryModel> addCategory(String menuId, CategoryModel category) async {
    logger.t("Adding category ${category.name} to firestore");

    // handle uploading image if imageFile is not null
    // if (category.imageFile != null) {
    //   category.image = await locator<StorageService>()
    //       .uploadFile('menus/$menuId/categories/${category.id}', category.imageFile!);
    // }
    // // add document to categories collection
    // final docRef = await db.collection('menus').doc(menuId).collection('categories').add(category.toJson());
    // // get document by docRef
    // DocumentSnapshot<Map<String, dynamic>> doc = await docRef.get();
    // return CategoryModel.fromSnapshot(doc);
    return CategoryModel.mock();
  }

  Future<CategoryModel> updateCategory(String menuId, CategoryModel category) async {
    logger.t("Updating category ${category.name} in firestore");

    // // handle uploading image if imageFile is not null
    // if (category.imageFile != null) {
    //   category.image = await locator<StorageService>()
    //       .uploadFile('menus/$menuId/categories/${category.id}', category.imageFile!);
    // }
    // // update document in categories collection
    // await db
    //     .collection('menus')
    //     .doc(menuId)
    //     .collection('categories')
    //     .doc(category.id)
    //     .update(category.toJson());
    // // get document by categoryId
    // DocumentSnapshot<Map<String, dynamic>> doc =
    //     await db.collection('menus').doc(menuId).collection('categories').doc(category.id).get();
    // return CategoryModel.fromSnapshot(doc);
    return CategoryModel.mock();
  }
}
