import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:valiq_editor_demo/models/account/account.model.dart';

class AccountService {
  final db = FirebaseFirestore.instance;
  final collectionName = 'accounts';

  /// Get account by id
  ///
  /// @param id
  Future<AccountModel> getById(String id) async {
    final doc = await db.collection(collectionName).doc(id).get();
    return AccountModel.fromSnapshot(doc);
  }

  Future<AccountModel> createFromCredential(User user) async {
    final doc = await db.collection(collectionName).doc(user.uid).get();
    if (doc.exists) {
      return AccountModel.fromSnapshot(doc);
    }
    final account = AccountModel(
      id: user.uid,
      email: user.email!,
      picture: user.photoURL,
      menus: [],
    );
    await db.collection(collectionName).doc(user.uid).set(account.toJson());
    return account;
  }

  Future<void> updateMenus(String id, List<String> menus) async {
    await db.collection(collectionName).doc(id).update({
      'menus': menus,
    });
  }
}
