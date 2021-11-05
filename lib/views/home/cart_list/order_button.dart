import 'package:flutter/material.dart';
import 'package:gossip/models/order.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/shared/loading.dart';

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
  bool _delete = false;
  bool _ordered = false;

  @override
  void initState() {
    super.initState();
    _qty = int.parse(widget.cartData.qty);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
            onPressed: () async => removeCartItem(),
            icon: Icon(Icons.delete_outline_rounded,
                color: Colors.redAccent.shade200, size: 22.0)),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
                onPressed: () => reduceQty(),
                icon: _delete
                    ? const Loading(white: false)
                    : const Icon(Icons.remove,
                        color: Colors.black54, size: 18.0)),
            Text(_qty.toString(),
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0)),
            IconButton(
              onPressed: () => increaseQty(),
              icon: const Icon(Icons.add, color: Colors.black54, size: 18.0),
            ),
          ],
        ),
        IconButton(
            onPressed: () => orderItem(),
            icon: _ordered
                ? const Loading(white: false)
                : Icon(Icons.check_circle_outline_rounded,
                    size: 22.0, color: Colors.teal.shade600)),
      ],
    );
  }

  Future<void> removeCartItem() async {
    setState(() => _delete = true);
    await DatabaseService(uid: widget.uid)
        .removeCartItem(widget.index)
        .whenComplete(() {
      widget.reloadCart;
      _delete = false;
    });
  }

  Future<void> orderItem() async {
    setState(() => _ordered = true);
    await DatabaseService(uid: widget.uid).updateUserOrders(OrderData(
      name: widget.cartData.name,
      item: widget.cartData.item,
      qty: _qty,
      price: widget.cartData.discPrice ?? widget.cartData.price,
    ));
    await DatabaseService(uid: widget.uid)
        .removeCartItem(widget.index)
        .whenComplete(() {
      widget.reloadCart;
      _ordered = false;
    });
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
