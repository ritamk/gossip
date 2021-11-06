import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/models/order.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/shared/loading.dart';

class ConfirmOrderDialog extends StatefulWidget {
  const ConfirmOrderDialog({
    Key? key,
    required this.cartData,
    required this.qty,
    required this.index,
    required this.uid,
    required this.reloadCart,
  }) : super(key: key);
  final String uid;
  final int qty;
  final int index;
  final CartData cartData;
  final Future<void> reloadCart;

  @override
  _ConfirmOrderDialogState createState() => _ConfirmOrderDialogState();
}

class _ConfirmOrderDialogState extends State<ConfirmOrderDialog> {
  bool _home = false;
  bool _gossip = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Choose order type"),
      content: const Text("Where would you like to eat?\n"
          "Home delivery charges applied."),
      actions: <Widget>[
        CupertinoDialogAction(
          child: !_home ? const Text("At Home") : const Loading(white: false),
          onPressed: () async => orderItem(true),
        ),
        CupertinoDialogAction(
          child:
              !_gossip ? const Text("At Gossip") : const Loading(white: false),
          onPressed: () async => orderItem(false),
        ),
      ],
    );
  }

  Future<void> orderItem(bool home) async {
    setState(() => home ? _home = true : _gossip = true);
    await DatabaseService(uid: widget.uid).updateUserOrders(OrderData(
        name: widget.cartData.name,
        item: widget.cartData.item,
        qty: widget.qty,
        price: widget.cartData.discPrice ?? widget.cartData.price,
        delivery: home));
    await DatabaseService(uid: widget.uid)
        .removeCartItem(widget.index)
        .then((val) {
      setState(() {
        if (val != 1) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Order placed!")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text("Something went wrong, order couldn't be placed.")));
        }
        Navigator.pop(context);
      });
      widget.reloadCart;
    });
  }
}
