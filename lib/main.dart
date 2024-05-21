import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sawah_app/Screens/NavBar.dart';
import 'package:sawah_app/login_page.dart';
import 'package:sawah_app/regester.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (context) => MyNevBar(),
        'HomePage': (context) => MyNevBar(),
        'register': (context) => const RegisterPage(),
        'login': (context) => const LoginPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
