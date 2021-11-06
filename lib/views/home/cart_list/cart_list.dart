import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/models/order.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/shared/loading.dart';
import 'package:gossip/views/home/cart_list/cart_tile.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List<CartData>? _cartFood = [];

  Future<void> _initCart() async {
    return DatabaseService(uid: widget.uid)
        .cartList
        .then((value) => setState(() => _cartFood = value));
  }

  @override
  void initState() {
    super.initState();
    _initCart();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            onRefresh: () async => _initCart(),
          ),
          SliverToBoxAdapter(
            child: _cartFood != null
                ? ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: _cartFood!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _cartFood!.isNotEmpty
                          ? CartTile(
                              cartData: _cartFood![index],
                              uid: widget.uid,
                              index: index,
                              reloadCart: _initCart(),
                            )
                          : const Loading(white: false, rad: 14);
                    },
                  )
                : const Loading(white: false, rad: 14),
          ),
        ],
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
      ),
      floatingActionButton: _cartFood != null
          ? _cartFood!.isNotEmpty
              ? FloatingActionButton.extended(
                  splashColor: Colors.purple,
                  highlightElevation: 0.0,
                  elevation: 0.0,
                  onPressed: () {},
                  label: Row(
                    children: const <Widget>[
                      Icon(Icons.check),
                      SizedBox(width: 5.0, height: 0.0),
                      Text(
                        "Order",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : const SizedBox(height: 0.0, width: 0.0)
          : const SizedBox(height: 0.0, width: 0.0),
    );
  }
}
