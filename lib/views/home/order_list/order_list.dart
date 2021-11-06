import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/models/order.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/shared/loading.dart';
import 'package:gossip/views/home/order_list/order_Tile.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<OrderData>? _orderList = [];

  Future<void> _initOrderList() async {
    return await DatabaseService(uid: widget.uid)
        .userOrders
        .then((value) => setState(() => _orderList = value));
  }

  @override
  void initState() {
    super.initState();
    _initOrderList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _orderList != null
                ? _orderList!.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _orderList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return OrderTile(orderData: _orderList![index]);
                        },
                      )
                    : const Loading(white: false, rad: 14.0)
                : const Loading(white: false, rad: 14.0),
          ),
        ],
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
      ),
    );
  }
}
