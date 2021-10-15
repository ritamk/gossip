import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/pages/home/home.dart';
import 'package:gossip/services/authentication.dart';
import 'package:gossip/shared/buttons.dart';
import 'package:gossip/shared/loading.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = "";
  String mail = "";
  String pass = "";
  bool _hidePassword = true;
  bool loading = false;
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _mailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign-Up")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // Name form field
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 4.0),
                  decoration: authTextContainerDecoration(),
                  child: TextFormField(
                    decoration: authTextInputDecoration("Name", Icons.person),
                    focusNode: _nameFocusNode,
                    validator: (val) =>
                        val!.isEmpty ? "Please enter your name" : null,
                    onChanged: (val) => name = val,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (val) =>
                        FocusScope.of(context).requestFocus(_mailFocusNode),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                  width: 0.0,
                ),
                // Email form field
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 4.0),
                  decoration: authTextContainerDecoration(),
                  child: TextFormField(
                    decoration: authTextInputDecoration("Email", Icons.mail),
                    focusNode: _mailFocusNode,
                    validator: (val) =>
                        val!.isEmpty ? "Please enter a valid email" : null,
                    onChanged: (val) => mail = val,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (val) =>
                        FocusScope.of(context).requestFocus(_passFocusNode),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                  width: 0.0,
                ),
                // Password form field
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 4.0),
                  decoration: authTextContainerDecoration(),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.vpn_key),
                      labelText: "Password",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      suffixIcon: IconButton(
                          onPressed: () => setState(
                                () => _hidePassword = !_hidePassword,
                              ),
                          icon: (_hidePassword)
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                    ),
                    focusNode: _passFocusNode,
                    validator: (val) => (val!.length < 6)
                        ? "Please enter a password with\nmore than 6 characters"
                        : null,
                    onChanged: (val) => pass = val,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (val) => FocusScope.of(context).unfocus(),
                    obscureText: _hidePassword,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                  width: 0.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  decoration: authButtonDecoration(),
                  child: TextButton(
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () async {
                      await signUpLogic(context);
                    },
                    child: loading
                        ? const Loading(
                            color: Colors.white,
                          )
                        : const Text(
                            "Sign-up",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpLogic(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      dynamic result =
          await AuthenticationService().registerWithMailPass(name, mail, pass);
      result != null
          ? Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(builder: (builder) => const HomePage()),
              (route) => false)
          : setState(() {
              loading = false;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    "Couldn't sign-up, please try again later.\nPlease check credentials and/or network connection."),
              ));
            });
    }
  }
}
