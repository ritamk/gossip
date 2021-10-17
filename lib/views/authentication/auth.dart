import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/views/authentication/sign_in.dart';
import 'package:gossip/views/authentication/sign_up.dart';
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
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: "Gossip",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.redAccent.shade200,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "\twelcomes you!",
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.redAccent.shade200,
                  ),
                ),
                const TextSpan(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Sign in button.
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    decoration: authButtonDecoration().copyWith(
                      color: Colors.redAccent.shade200,
                    ),
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
                  const SizedBox(
                    height: 20.0,
                    width: 0.0,
                  ),
                  // Sign up button
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    decoration: authButtonDecoration().copyWith(
                      color: Colors.black54,
                    ),
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
