import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/pages/authentication/auth.dart';
import 'package:gossip/pages/home/home.dart';
import 'package:gossip/services/providers.dart';
import 'package:gossip/shared/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
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
      // Consumer(
      //     builder: (context, ref, child) =>
      //         ref(userModelProvider).data?.value?.uid != null
      //             ? const HomePage()
      //             : const AuthPage()),
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
