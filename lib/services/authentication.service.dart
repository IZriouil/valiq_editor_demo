import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationService() {
    _auth.setPersistence(Persistence.LOCAL);
  }

  Stream<User?> get authStateChanges {
    return _auth.authStateChanges();
  }

  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      // return AccountModel.mock();
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.i(userCredential.additionalUserInfo.jsify());
      return userCredential;
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    // Once signed in, return the UserCredential
    return _auth.signInWithPopup(googleProvider);
  }

  Future<UserCredential> signInWithFacebook() async {
    FacebookAuthProvider facebookProvider = FacebookAuthProvider();

    facebookProvider.addScope('email');
    facebookProvider.addScope('public_profile');
    facebookProvider.setCustomParameters({
      'display': 'popup',
    });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(facebookProvider);
  }

  bool isAuthenticated() {
    return _auth.currentUser != null;
  }
}
