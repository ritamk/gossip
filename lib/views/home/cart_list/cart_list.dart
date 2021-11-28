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
  late double _containerWidth;

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
    _containerWidth = MediaQuery.of(context).size.width - 50.0;

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
                          : const Loading(white: false);
                    },
                  )
                : const Loading(white: false, rad: 14),
          ),
        ],
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _cartFood != null
          ? _cartFood!.isNotEmpty
              ? FloatingActionButton.extended(
                  extendedPadding: const EdgeInsets.all(0.0),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.red,
                  splashColor: Colors.purple,
                  highlightElevation: 0.0,
                  elevation: 0.0,
                  onPressed: () {},
                  label: SizedBox(
                    width: _containerWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            const SizedBox(width: 16.0, height: 0.0),
                            const Text(
                              "Total: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("₹${orderTotal(_cartFood).toString()}",
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.red),
                          child: Row(
                            children: const <Widget>[
                              Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5.0, height: 0.0),
                              Text("Order",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(child: Loading(white: false, rad: 14.0))
          : const SizedBox(width: 0.0, height: 0.0),
    );
  }

  int orderTotal(List<CartData>? cartFood) {
    int total = 0;
    for (CartData element in cartFood!) {
      total += element.discPrice ?? element.price;
    }
    return total;
  }
}
