import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/services/providers.dart';
import 'package:gossip/views/home/bottom_nav.dart';
import 'package:gossip/views/home/cart_list/cart_list.dart';
import 'package:gossip/views/home/food_list/food_list.dart';
import 'package:gossip/views/home/order_list/order_list.dart';
import 'package:gossip/views/home/profile.dart';
import 'package:gossip/views/home/search_list/search_list.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String userID = ref.watch((userModelStreamProvider)).value!.uid;

    final List<Widget> _pages = [
      const FoodList(),
      const SearchList(),
      CartList(uid: userID),
      OrderList(uid: userID),
      Profile(uid: userID),
    ];

    return Scaffold(
      body: _pages[ref.watch(bottomNavSelectedProvider)],
      bottomNavigationBar: BottomNavBar(uid: userID),
    );
  }
}
