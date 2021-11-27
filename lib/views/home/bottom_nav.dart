import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/services/providers.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      return BottomNavigationBar(
        currentIndex: ref.watch(bottomNavSelectedProvider),
        onTap: (index) => setState(
            () => ref.watch(bottomNavSelectedProvider.state).state = index),
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 30.0),
              activeIcon: Icon(
                Icons.home_rounded,
                size: 38.0,
              ),
              label: "Home"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, size: 30.0),
              activeIcon: Icon(
                Icons.search,
                size: 38.0,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: StreamBuilder<int>(
                  stream: DatabaseService(uid: widget.uid).cartCount,
                  builder: (context, snapshot) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        const Icon(Icons.shopping_cart_outlined, size: 30.0),
                        snapshot.hasData
                            ? snapshot.data != 0
                                ? Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.9),
                                        shape: BoxShape.circle),
                                    constraints: const BoxConstraints(
                                        maxHeight: 18.0,
                                        maxWidth: 18.0,
                                        minHeight: 18.0,
                                        minWidth: 18.0),
                                    child: Text(
                                      snapshot.data!.toString(),
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      softWrap: true,
                                    ),
                                  )
                                : const SizedBox(height: 0.0, width: 0.0)
                            : const SizedBox(height: 0.0, width: 0.0),
                      ],
                    );
                  }),
              activeIcon: const Icon(
                Icons.shopping_cart_rounded,
                size: 38.0,
              ),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: StreamBuilder<int>(
                  stream: DatabaseService(uid: widget.uid).orderCount,
                  builder: (context, snapshot) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        const Icon(Icons.shopping_bag_outlined, size: 30.0),
                        snapshot.hasData
                            ? snapshot.data != 0
                                ? Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.9),
                                        shape: BoxShape.circle),
                                    constraints: const BoxConstraints(
                                        maxHeight: 18.0,
                                        maxWidth: 18.0,
                                        minHeight: 18.0,
                                        minWidth: 18.0),
                                    child: Text(
                                      snapshot.data!.toString(),
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      softWrap: true,
                                    ),
                                  )
                                : const SizedBox(height: 0.0, width: 0.0)
                            : const SizedBox(height: 0.0, width: 0.0),
                      ],
                    );
                  }),
              activeIcon: const Icon(
                Icons.shopping_bag_rounded,
                size: 38.0,
              ),
              label: "Orders"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded, size: 30.0),
              activeIcon: Icon(
                Icons.person_rounded,
                size: 38.0,
              ),
              label: "Home"),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      );
    });
  }
}
