import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/views/add_food/add_food.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/shared/loading.dart';

class ShowFood extends StatefulWidget {
  const ShowFood({Key? key}) : super(key: key);

  @override
  State<ShowFood> createState() => _ShowFoodState();
}

class _ShowFoodState extends State<ShowFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Show Food")),
      body: RefreshIndicator(
        onRefresh: () async => setState(() {}),
        child: FutureBuilder(
          future: DatabaseService().foodList,
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return !snapshot.hasData
                ? const Loading(color: Colors.red)
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text("${snapshot.data[index].name}"),
                      );
                    },
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(CupertinoPageRoute(builder: (builder) => const AddFood())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
