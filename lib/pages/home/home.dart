import 'package:flutter/material.dart';
import 'package:gossip/services/authentication.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                AuthenticationService().signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
