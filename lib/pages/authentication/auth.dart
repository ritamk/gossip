import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/pages/authentication/sign_in.dart';
import 'package:gossip/pages/authentication/sign_up.dart';
import 'package:gossip/shared/buttons.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          RichText(
            text: const TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: "Gossip",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "\twelcomes you!",
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.black54,
                  ),
                ),
                TextSpan(
                  text: "\nPlease login or sign-up to continue.",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    decoration: authButtonDecoration(),
                    child: TextButton(
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                              builder: (builder) => const SignInPage())),
                      child: const Text(
                        "Sign-in",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    decoration: authButtonDecoration(),
                    child: TextButton(
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                              builder: (builder) => const SignUpPage())),
                      child: const Text(
                        "Sign-up",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
