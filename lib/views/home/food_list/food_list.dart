import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/models/food.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/shared/loading.dart';
import 'package:gossip/views/home/food_list/food_tile.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  List<Food>? _foodList = [];
  bool _moreFood = true;
  final ScrollController _scrollController = ScrollController();

  Future<void> _initFoodList() async {
    return await DatabaseService()
        .foodList
        .then((value) => setState(() => _foodList = value));
  }

  Future<void> _moreFoodList() async {
    return await DatabaseService().moreFoodList.then((value) {
      if (_foodList != null && value != null) {
        setState(() => _foodList = _foodList! + value);
      } else {
        setState(() => _moreFood = false);
      }
    });
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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                  itemCount: _foodList!.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < _foodList!.length) {
                      return FoodListTile(food: _foodList![index]);
                    } else {
                      return _moreFood
                          ? const Loading(color: Colors.black)
                          : const SizedBox(height: 0.0, width: 0.0);
                    }
                  })
              : const Loading(color: Colors.black),
        ),
      ],
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      controller: _scrollController,
    );
  }
}
