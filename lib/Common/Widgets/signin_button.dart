import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/Common/constants/constants.dart';
import 'package:reddit/Features/Auth/Controllers/authController.dart';
import 'package:reddit/Features/Auth/Repository/authRepository.dart';
import 'package:reddit/theme/pallete.dart';

class SignInButton extends ConsumerWidget {
  //final bool isFromLogin;

  void signInWithGoogle(WidgetRef ref,BuildContext context) {
    ref.read(authControllerProvider).googleSignin(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        onPressed: () {
          signInWithGoogle(ref,context);
        },
        icon: Image.asset(
          Constants.googlePath,
          width: 35,
        ),
        label: const Text(
          'Continue with Google',
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.greyColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
