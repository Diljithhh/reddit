import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/Features/Auth/Controllers/authController.dart';
import 'package:reddit/Features/Auth/Screens/login_screen.dart';
import 'package:reddit/Models/userModel.dart';
import 'package:reddit/firebase_options.dart';
import 'package:reddit/theme/eroorPage.dart';
import 'package:reddit/theme/pallete.dart';
import 'package:reddit/theme/routes.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late UserModel userModel;

  getuserdata(WidgetRef ref, User data) async {
    print('fn called 1');
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserdata(data.uid)
        .first;

    ref.read(userdataProvider.notifier).update((state) => userModel);
    print("neww${userModel.name}");

    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userauthstatechangeprovider).when(
          data: (data) {
             print('User authentication state changed.');
                getuserdata(ref, data);

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: Pallete.darkModeAppTheme,
              routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                if (data != null) {
                  return loggedinRoute;
                } else {
                  return loggedOutRoute;
                }
              }),
              routeInformationParser: const RoutemasterParser(),
            );
          },
          error: (error, stackTrace) => const ErrorPage(),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
