import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/services/authentication.dart';
import 'package:gossip/views/home/bottom_nav.dart';
import 'package:gossip/views/home/food_list/food_list.dart';

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
      body: const FoodList(),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
