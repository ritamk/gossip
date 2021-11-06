import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/services/providers.dart';
import 'package:gossip/views/home/bottom_nav.dart';
import 'package:gossip/views/home/cart_list/cart_list.dart';
import 'package:gossip/views/home/food_list/food_list.dart';
import 'package:gossip/views/home/order_list/order_list.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final String userID = watch(userModelStreamProvider).data!.value!.uid;

    final List<Widget> _pages = [
      const FoodList(),
      CartList(uid: userID),
      OrderList(uid: userID)
    ];

    return Scaffold(
      body: _pages[watch(bottomNavSelectedProvider).state],
      bottomNavigationBar: BottomNavBar(uid: userID),
    );
  }
}
