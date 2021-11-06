// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:gossip/models/order.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({Key? key, required this.orderData}) : super(key: key);
  final OrderData orderData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            orderData.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18.0, color: Colors.black87),
                  children: <InlineSpan>[
                    const TextSpan(
                        text: "₹ ", style: TextStyle(fontSize: 16.0)),
                    TextSpan(text: orderData.price.toString()),
                  ],
                ),
              ),
              const Text("\t\t\t●\t\t\t"),
              Text(orderData.qty.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
