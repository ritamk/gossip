import 'package:flutter/material.dart';
import 'package:gossip/models/order.dart';

class CartTileOrderButton extends StatefulWidget {
  const CartTileOrderButton(
      {Key? key, required this.cartData, required this.uid})
      : super(key: key);
  final CartData cartData;
  final String uid;

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete, color: Colors.redAccent)),
        const Divider(),
        Container(
          decoration: BoxDecoration(
              color: Colors.white10, borderRadius: BorderRadius.circular(25.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  onPressed: () => reduceQty(),
                  icon: const Icon(Icons.remove,
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
        ),
      ],
    );
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
