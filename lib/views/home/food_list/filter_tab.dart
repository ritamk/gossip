import 'package:flutter/material.dart';

class FilterTabBar extends StatefulWidget {
  const FilterTabBar({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  State<FilterTabBar> createState() => _FilterTabBarState();
}

class _FilterTabBarState extends State<FilterTabBar> {
  final List<String> _filters = <String>[
    "All",
    "Pizza",
    "Starter",
  ];
  int _currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: (val) => setState(() => _currIndex = val),
      tabs: <Widget>[
        tabBarTile(0),
        tabBarTile(1),
        tabBarTile(2),
      ],
      controller: widget.tabController,
      isScrollable: true,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Colors.transparent,
      labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      indicatorPadding: const EdgeInsets.all(0.0),
      padding: const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
    );
  }

  Widget tabBarTile(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.center,
      height: 50.0,
      child: Text(
        _filters[index],
        style: _currIndex == index
            ? const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)
            : const TextStyle(
                fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.red),
      ),
      decoration: _currIndex == index
          ? BoxDecoration(
              color: Colors.red,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.red.shade100,
                    offset: const Offset(0.0, 3.0),
                    blurRadius: 6.0,
                    spreadRadius: 2.0),
              ],
              borderRadius: BorderRadius.circular(25.0))
          : BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
    );
  }
}
