import 'package:flutter/material.dart';
import 'package:gossip/models/order.dart';

class CartTile extends StatelessWidget {
  const CartTile({Key? key, required this.cartData}) : super(key: key);
  final CartData cartData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(
          cartData.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Text(cartData.qty),
            const Text("\t\t\t●\t\t\t"),
            Text("₹ ${cartData.price}"),
          ],
        ),
        trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
      ),
    );
  }
}
