import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/models/food.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/shared/loading.dart';
import 'package:gossip/views/home/food_tile.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  List<Food>? _foodList;

  Future<void> _initFoodList() async {
    return await DatabaseService()
        .foodList
        .then((value) => setState(() => _foodList = value));
  }

  @override
  void initState() {
    super.initState();
    _initFoodList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverRefreshControl(onRefresh: () async => _initFoodList()),
        SliverToBoxAdapter(
          child: _foodList != null
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _foodList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FoodListTile(food: _foodList![index]);
                  },
                )
              : const Loading(color: Colors.black),
        ),
      ],
      primary: true,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    );
  }
}
