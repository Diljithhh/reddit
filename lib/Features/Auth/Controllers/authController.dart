import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/Common/Utils/snackBar.dart';
import 'package:reddit/Features/Auth/Repository/authRepository.dart';
import 'package:reddit/Models/userModel.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(ref.watch(authRepositoryProvider), ref);
});

final userdataProvider = StateProvider<UserModel?>((ref) => null);

// provider for watching user loggedin or not
final userauthstatechangeprovider = StreamProvider((ref) {
  final authcontroler = ref.watch(authControllerProvider.notifier);

  return authcontroler.authstate;
});

final getuserdataProvider = StreamProvider.family((ref, String uid) {
  final authcontroler = ref.watch(authControllerProvider.notifier);

  return authcontroler.getUserdata(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  final Ref _ref;

  AuthController(this._authRepository, this._ref) : super(false);

  void googleSignin(BuildContext context) async {
    state = true;
    final user = await _authRepository.signinWithGoogle();
    state = false;
    user.fold((l) {
      showSnackBar(context, l.message);
    }, (r) => _ref.watch(userdataProvider.notifier).update((state) => r));
  }

  Stream get authstate => _authRepository.authStateChange;

  Stream<UserModel> getUserdata(String uid) {
    return _authRepository.getUserdata(uid);
  }

  logout() {
    _authRepository.signOut();

    print('logout');
  }
}
