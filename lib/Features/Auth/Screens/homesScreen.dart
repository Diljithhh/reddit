import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/Features/Auth/Controllers/authController.dart';
import 'package:reddit/Features/Auth/Repository/authRepository.dart';

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.access_alarms),
        actions: [
          IconButton(
              onPressed: () {
                ref.watch(authControllerProvider.notifier).logout();
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      body:  Center(
        child: Text(ref.read(userdataProvider)?.name??'hello'),
      ),
    );
  }
}
