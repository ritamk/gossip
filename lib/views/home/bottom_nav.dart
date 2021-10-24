import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/models/order.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/services/providers.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currIndex,
      onTap: (index) => setState(() => _currIndex = index),
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30.0),
            activeIcon: Icon(
              Icons.home_rounded,
              size: 38.0,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Consumer(builder: (context, ref, child) {
              return StreamBuilder<List<CartData?>>(
                  stream: DatabaseService(
                          uid: ref(userModelStreamProvider).data!.value!.uid)
                      .cartData,
                  builder: (context, snapshot) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        const Icon(Icons.shopping_cart_outlined, size: 30.0),
                        snapshot.hasData
                            ? Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(1.0),
                                    shape: BoxShape.circle),
                                constraints: const BoxConstraints(
                                    maxHeight: 18.0,
                                    maxWidth: 18.0,
                                    minHeight: 18.0,
                                    minWidth: 18.0),
                                child: Text(
                                  snapshot.data?.length.toString() ?? "0",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                  softWrap: true,
                                ),
                              )
                            : const SizedBox(height: 0.0, width: 0.0),
                      ],
                    );
                  });
            }),
            activeIcon: const Icon(
              Icons.shopping_cart_rounded,
              size: 38.0,
            ),
            label: "Cart"),
      ],
    );
  }
}
