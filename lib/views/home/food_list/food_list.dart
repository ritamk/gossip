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
    return Scaffold(
      appBar: AppBar(title: const Text("Menu")),
      body: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverRefreshControl(onRefresh: () async => _initFoodList()),
          SliverToBoxAdapter(
            child: _foodList?.isNotEmpty ?? false
                ? ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: _foodList!.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return index < _foodList!.length
                          ? FoodListTile(food: _foodList![index])
                          : _moreFood
                              ? const Loading(white: false)
                              : const SizedBox(height: 0.0, width: 0.0);
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
}
