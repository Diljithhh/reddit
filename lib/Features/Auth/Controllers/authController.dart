import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/Features/Auth/Repository/authRepository.dart';





final authControllerProvider = Provider((ref) {
  return AuthController(ref.read(authRepositoryProvider)) ;
});

class AuthController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  void googleSignin() {
    _authRepository.signinWithGoogle();
  }
}
