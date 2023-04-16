import 'package:flutter/material.dart';
import 'package:reddit/Common/Widgets/signin_button.dart';
import 'package:reddit/Common/constants/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  // void signInAsGuest(WidgetRef ref, BuildContext context) {
  //   ref.read(authControllerProvider.notifier).signInAsGuest(context);
  // }

  @override
  Widget build(BuildContext context,) {
    //final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPath,
          height: 40,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Skip',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]),body: Column(
          children: [
            Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        Constants.loginEmotePath,
                        height: 400,
                      ),
                    ),
         SignInButton() ],
        ),);
      
     
 
  }
}