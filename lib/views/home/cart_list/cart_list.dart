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
  List<CartData> _cartFood = [];

  Future<void> _initCart() async {
    return await DatabaseService(uid: widget.uid)
        .cartList
        .then((value) => setState(() {
              _cartFood = value;
            }));
  }

  @override
  void initState() {
    super.initState();
    _initCart();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverRefreshControl(
          onRefresh: () async => _initCart(),
        ),
        SliverToBoxAdapter(
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: _cartFood.length,
            itemBuilder: (BuildContext context, int index) {
              return _cartFood.isNotEmpty
                  ? CartTile(
                      cartData: _cartFood[index],
                      uid: widget.uid,
                      index: index,
                      reloadCart: _initCart(),
                    )
                  : const Loading(white: false);
            },
          ),
        ),
      ],
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    );
  }
}
