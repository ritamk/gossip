import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/views/authentication/auth.dart';
import 'package:gossip/views/home/home.dart';
import 'package:gossip/services/providers.dart';

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
      home: Consumer(
          builder: (context, ref, child) =>
              ref(userModelStreamProvider).data?.value?.uid != null
                  ? const HomePage()
                  : const AuthPage()),
    );
  }
}

ThemeData mainTheme() {
  return ThemeData(
    fontFamily: "Montserrat",
    // dividerColor: Colors.transparent,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white10,
      elevation: 0.0,
    ),
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
