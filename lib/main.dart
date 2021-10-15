import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gossip/pages/authentication/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gossip',
      debugShowCheckedModeBanner: false,
      theme: mainTheme(),
      home: const AuthPage(),
    );
  }
}

ThemeData mainTheme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        color: Colors.red,
      ),
      backgroundColor: Colors.white10,
      foregroundColor: Colors.red,
    ),
    primarySwatch: Colors.red,
  );
}
