import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/Common/Utils/snackBar.dart';
import 'package:reddit/Common/failures.dart';
import 'package:reddit/Features/Auth/Repository/authRepository.dart';

final authControllerProvider = Provider((ref) {
  return AuthController(ref.read(authRepositoryProvider));
});

class AuthController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  void googleSignin(BuildContext context) async {
    final user = await _authRepository.signinWithGoogle();
    user.fold((l) {
showSnackBar(context, l.message);

    }, (r) => null);
  }
}
