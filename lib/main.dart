import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reddit/Features/Auth/Screens/login_screen.dart';
import 'package:reddit/firebase_options.dart';
import 'package:reddit/theme/pallete.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: Pallete.darkModeAppTheme,
      home: LoginScreen(),);
  }
}
