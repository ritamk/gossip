import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/services/authentication.dart';
import 'package:gossip/services/providers.dart';
import 'package:gossip/views/home/bottom_nav.dart';
import 'package:gossip/views/home/cart_list/cart_list.dart';
import 'package:gossip/views/home/food_list/food_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(builder: (context, ref, child) {
          switch (ref(bottomNavSelectedProvider).state) {
            case 0:
              return const Text("Home");
            case 1:
              return const Text("Cart");
            default:
              return const Text("Home");
          }
        }),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                AuthenticationService().signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Consumer(builder: (context, ref, child) {
        switch (ref(bottomNavSelectedProvider).state) {
          case 0:
            return const FoodList();
          case 1:
            return Consumer(builder: (context, ref, child) {
              return CartList(
                  uid: ref(userModelStreamProvider).data!.value!.uid);
            });
          default:
            return const FoodList();
        }
      }),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
