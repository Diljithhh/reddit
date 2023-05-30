import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/Features/Auth/Controllers/authController.dart';
import 'package:reddit/Features/Auth/Repository/authRepository.dart';
import 'package:reddit/Features/Auth/Screens/login_screen.dart';

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userdataProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.access_alarms),
        actions: [
          IconButton(
              onPressed: () {
                ref.watch(authControllerProvider.notifier).logout();

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return
                    const LoginScreen();
                  },
                ));
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      body: Center(
        child: Text(user?.name ?? 'sas'),
      ),
    );
  }
}
