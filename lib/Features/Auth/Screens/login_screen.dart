import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/Common/Utils/loader.dart';
import 'package:reddit/Common/Widgets/signin_button.dart';
import 'package:reddit/Common/constants/constants.dart';
import 'package:reddit/Features/Auth/Controllers/authController.dart';
import 'package:reddit/theme/eroorPage.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  // void signInAsGuest(WidgetRef ref, BuildContext context) {
  //   ref.read(authControllerProvider.notifier).signInAsGuest(context);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);

    final value = ref.read(userdataProvider);
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
            ]),
        body: isLoading
            ? const Loader()
            : ref.watch(userauthstatechangeprovider).when(
                data: (data) {


                  
                  return Column(
                    children: [
                      Text(value?.name ?? 'not loggedin'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          Constants.loginEmotePath,
                          height: 400,
                        ),
                      ),
                      SignInButton(),
                      StreamBuilder(
                        builder: (context, snapshot) {
                          return Container();
                        },
                      )
                    ],
                  );
                },
                error: (error, stackTrace) => const ErrorPage(),
    loading: () => const CircularProgressIndicator(), ) );
  }
}
