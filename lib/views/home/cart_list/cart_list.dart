import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/models/order.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/services/providers.dart';
import 'package:gossip/shared/loading.dart';
import 'package:gossip/views/home/cart_list/cart_tile.dart';
import 'package:gossip/views/home/cart_list/multi_delivery_dialog.dart';

class CartList extends ConsumerStatefulWidget {
  const CartList({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends ConsumerState<CartList> {
  Future<void> _initCart() async {
    return DatabaseService(uid: widget.uid).cartList.then((value) =>
        setState(() => ref.watch(cartListProvider.state).state = value));
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
    final StateController<List<CartData>?> cartFoodController =
        ref.watch(cartListProvider.state);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: cartFoodController.state != null
                ? ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: cartFoodController.state?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return cartFoodController.state!.isNotEmpty
                          ? CartTile(
                              cartData: cartFoodController.state![index],
                              qty: cartFoodController,
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
      floatingActionButton: cartFoodController.state != null
          ? cartFoodController.state!.isNotEmpty
              ? FloatingActionButton.extended(
                  splashColor: Colors.purple,
                  highlightElevation: 0.0,
                  elevation: 0.0,
                  onPressed: () => Navigator.of(context).push(
                      CupertinoDialogRoute(
                          builder: (builder) => ConfirmMultiOrderDialog(
                              uid: widget.uid, reloadCart: _initCart()),
                          context: context)),
                  label: Row(
                    children: const <Widget>[
                      Icon(Icons.check),
                      SizedBox(width: 5.0, height: 0.0),
                      Text("Order",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              : const SizedBox(width: 0.0, height: 0.0)
          : const SizedBox(width: 0.0, height: 0.0),
    );
  }

  int orderTotal(List<CartData>? cartFoodController) {
    int total = 0;
    for (CartData element in cartFoodController!) {
      total += element.discPrice ?? element.price;
    }
    return total;
  }
}
