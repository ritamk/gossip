import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/shared/loading.dart';
import 'package:gossip/views/home/food_tile.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverRefreshControl(onRefresh: () async => setState(() {})),
        SliverToBoxAdapter(
          child: FutureBuilder(
            future: DatabaseService().foodList,
            initialData: const [],
            builder: (BuildContext context, AsyncSnapshot snapshot) =>
                snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            FoodListTile(food: snapshot.data[index]),
                      )
                    : const Loading(color: Colors.black),
          ),
        ),
      ],
      primary: true,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    );
  }
}
