import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valiq_editor_demo/config/service_locator.dart';
import 'package:valiq_editor_demo/models/account/account.model.dart';
import 'package:valiq_editor_demo/services/account.service.dart';
import 'package:valiq_editor_demo/services/authentication.service.dart';

class AuthCubit extends Cubit<AccountModel?> {
  AuthenticationService get _authService => locator<AuthenticationService>();
  AccountService get _accountService => locator<AccountService>();

  AuthCubit() : super(null) {
    _authService.authStateChanges.listen(listen);
  }

  void listen(User? user) {
    if (user == null) {
      emit(null);
      return;
    }
    _accountService.createFromCredential(user).then((account) {
      emit(account);
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _authService.signInWithEmailAndPassword(email, password);
  }

  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
  }

  Future<void> signInWithFacebook() async {
    await _authService.signInWithFacebook();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    emit(null);
  }

  Future<void> refreshAuthAccount() async {
    final account = await _accountService.getById(state!.id);
    emit(account);
  }

  // @override
  // Future<void> close() async {
  //   super.close();
  // }
}
