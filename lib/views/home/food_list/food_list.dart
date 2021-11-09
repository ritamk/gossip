import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/models/food.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/shared/loading.dart';
import 'package:gossip/views/home/food_list/food_tile.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList>
    with SingleTickerProviderStateMixin {
  List<Food>? _foodList = [];

  bool _moreFood = true;
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  final List<String> _filters = <String>[
    "",
    "pizza",
    "starter",
  ];
  final List<String> _filterTitles = <String>[
    "All",
    "Pizzas",
    "Starters",
  ];
  int _currIndex = 0;

  Future<void> _initFoodList() async {
    return await DatabaseService()
        .foodList
        .then((value) => setState(() => _foodList = value));
  }

  Future<void> _moreFoodList() async {
    return await DatabaseService().moreFoodList.then((value) {
      if (value != null) {
        setState(() => _foodList = _foodList! + value);
      } else {
        setState(() => _moreFood = false);
      }
    });
  }

  Future<void> _filterChange(String filter) async {
    if (filter.isNotEmpty) {
      _foodList?.clear();
      return await DatabaseService(filter: filter)
          .filteredFoodList
          .then((value) => setState(() => _foodList = value));
    } else {
      return await _initFoodList();
    }
  }

  @override
  void initState() {
    super.initState();
    _initFoodList();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        _moreFood ? _moreFoodList() : null;
      }
    });
    _tabController = TabController(length: _filters.length, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            title: Text("Menu"),
            elevation: 0.0,
          ),
          SliverAppBar(
            title: Theme(
              data: Theme.of(context).copyWith(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              child: TabBar(
                onTap: (val) {
                  setState(() {
                    _currIndex = val;
                    _filterChange(_filters[val]);
                  });
                },
                tabs: <Widget>[
                  tabBarTile(0),
                  tabBarTile(1),
                  tabBarTile(2),
                ],
                labelStyle: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
                labelColor: Colors.white,
                unselectedLabelStyle: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.red,
                controller: _tabController,
                isScrollable: true,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.transparent,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                indicatorPadding: const EdgeInsets.all(0.0),
                padding: const EdgeInsets.all(10.0),
              ),
            ),
            toolbarHeight: 64.0,
            elevation: 0.0,
            pinned: true,
          ),
          CupertinoSliverRefreshControl(onRefresh: () async => _initFoodList()),
          SliverToBoxAdapter(
            child: _foodList?.isNotEmpty ?? false
                ? Consumer(builder: (context, ref, child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _foodList!.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return index < _foodList!.length
                              ? FoodListTile(food: _foodList![index])
                              : _moreFood
                                  ? const Loading(white: false)
                                  : const SizedBox(height: 0.0, width: 0.0);
                        });
                  })
                : const Loading(white: false, rad: 14.0),
          ),
        ],
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        controller: _scrollController,
      ),
    );
  }

  Widget tabBarTile(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      alignment: Alignment.center,
      height: 50.0,
      child: Text(_filterTitles[index]),
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
