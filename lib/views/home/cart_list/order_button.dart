import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/models/order.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/views/home/cart_list/delivery_dialog.dart';

class CartTileOrderButton extends StatefulWidget {
  const CartTileOrderButton(
      {Key? key,
      required this.cartData,
      required this.uid,
      required this.index,
      required this.reloadCart})
      : super(key: key);
  final CartData cartData;
  final String uid;
  final int index;
  final Future<void> reloadCart;

  @override
  _CartTileOrderButtonState createState() => _CartTileOrderButtonState();
}

class _CartTileOrderButtonState extends State<CartTileOrderButton> {
  late int _qty;

  @override
  void initState() {
    super.initState();
    _qty = int.parse(widget.cartData.qty);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          onPressed: () async => removeCartItem(),
          icon: Icon(Icons.delete_outline_rounded,
              color: Colors.redAccent.shade200, size: 22.0),
          tooltip: "Remove Item",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () => reduceQty(),
              icon: const Icon(Icons.remove, color: Colors.black54, size: 18.0),
              tooltip: "Reduce quantity",
            ),
            Text(
              _qty.toString(),
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            ),
            IconButton(
              onPressed: () => increaseQty(),
              icon: const Icon(Icons.add, color: Colors.black54, size: 18.0),
              tooltip: "Increase quantity",
            ),
          ],
        ),
        IconButton(
          onPressed: () => openDeliveryDialog(),
          icon: Icon(Icons.check_circle_outline_rounded,
              size: 22.0, color: Colors.teal.shade600),
          tooltip: "Make Order",
        ),
      ],
    );
  }

  Future<void> removeCartItem() async => await DatabaseService(uid: widget.uid)
      .removeCartItem(widget.index)
      .whenComplete(() => widget.reloadCart);

  openDeliveryDialog() {
    Navigator.of(context).push(CupertinoDialogRoute(
        builder: (builder) => ConfirmOrderDialog(
              cartData: widget.cartData,
              uid: widget.uid,
              qty: _qty,
              index: widget.index,
              reloadCart: widget.reloadCart,
            ),
        context: context));
  }

  void increaseQty() {
    if (_qty < 25) {
      setState(() => _qty++);
    }
  }

  void reduceQty() {
    if (_qty > 1) {
      setState(() => _qty--);
    }
  }
}
