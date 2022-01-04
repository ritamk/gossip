import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/models/order.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/services/providers.dart';
import 'package:gossip/shared/loading.dart';

class ConfirmMultiOrderDialog extends ConsumerStatefulWidget {
  const ConfirmMultiOrderDialog({
    Key? key,
    required this.uid,
    required this.reloadCart,
  }) : super(key: key);
  final String uid;

  final Future<void> reloadCart;

  @override
  _ConfirmMultiOrderDialogState createState() =>
      _ConfirmMultiOrderDialogState();
}

class _ConfirmMultiOrderDialogState
    extends ConsumerState<ConfirmMultiOrderDialog> {
  bool _home = false;
  bool _gossip = false;

  @override
  void initState() {
    super.initState();
  }

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
    for (CartData item in ref.watch(cartListProvider.state).state!) {
      await DatabaseService(uid: widget.uid).updateUserOrders(OrderData(
        name: item.name,
        item: item.item,
        qty: int.parse(item.qty),
        price: item.discPrice ?? item.price,
        delivery: home,
      ));
    }
    await DatabaseService(uid: widget.uid).emptyCart().then((val) {
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
