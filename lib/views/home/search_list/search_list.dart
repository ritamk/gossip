import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gossip/models/food.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/shared/buttons.dart';
import 'package:gossip/shared/loading.dart';
import 'package:gossip/views/home/food_list/food_tile.dart';
import 'package:gossip/views/home/search_list/search_help_dialog.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<Food>? _fullList = [];
  List<Food>? _searchList = [];
  String _text = "";

  @override
  void initState() {
    super.initState();
    _fillFullList();
  }

  Future<void> _fillFullList() async {
    if (_fullList!.isEmpty) {
      await DatabaseService()
          .searchFoodList
          .then((value) => setState(() => _fullList = value));
    }
  }

  Future<void> _getSearchList(String search) async {
    _searchList!.clear();
    if (_fullList!.isEmpty) {
      _fillFullList();
    }
    for (Food element in _fullList!) {
      element.name.toLowerCase().contains(search)
          ? _searchList!.add(element)
          : null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: TextField(
            decoration: profileInputDecoration().copyWith(
                hintText: "Search",
                suffixIcon: IconButton(
                  onPressed: () async =>
                      await _getSearchList(_text.toLowerCase()),
                  icon: const Icon(Icons.search),
                )),
            autofocus: true,
            onChanged: (val) => _text = val,
            onSubmitted: (val) async {
              FocusScope.of(context).unfocus();
              await _getSearchList(_text.toLowerCase());
            },
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () => Navigator.of(context).push(CupertinoDialogRoute(
                  builder: (builder) => const SearchHelpDialog(),
                  context: context)),
              icon: const Icon(Icons.help_rounded),
              tooltip: "Info"),
          const SizedBox(width: 16.0, height: 0.0),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          primary: true,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 28.0,
                height: 4.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.black26),
              ),
              const Text("\nSearch Result:\n"),
              _searchList?.isNotEmpty ?? false
                  ? ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _searchList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FoodListTile(food: _searchList![index]);
                      },
                    )
                  : const Align(
                      alignment: Alignment.topCenter,
                      child: Loading(white: false, rad: 14.0)),
            ],
          ),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
        ),
      ),
    );
  }
}
