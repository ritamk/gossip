import 'package:flutter/material.dart';
import 'package:gossip/models/order.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({Key? key, required this.orderData}) : super(key: key);
  final OrderData orderData;

  @override
  Widget build(BuildContext context) {
    final DateTime _dateTime =
        DateTime.parse(orderData.time!.toDate().toString());

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(orderData.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Row(
          children: <Widget>[
            const Text("₹ ",
                style: TextStyle(fontSize: 15.0, color: Colors.black87)),
            Text(orderData.price.toString(),
                style: const TextStyle(fontSize: 16.0, color: Colors.black87)),
            const Text("\t\t●\t\t",
                style: TextStyle(fontSize: 10.0, color: Colors.black87)),
            Text(orderData.qty.toString(),
                style: const TextStyle(fontSize: 16.0, color: Colors.black87)),
            const Text("\t\t●\t\t",
                style: TextStyle(fontSize: 10.0, color: Colors.black87)),
            Text(orderData.delivery! ? "At Home" : "At Gossip",
                style: const TextStyle(fontSize: 16.0, color: Colors.black87)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              "Ordered on:",
              style: TextStyle(color: Colors.black87),
            ),
            Text(DateFormat.yMMMd().format(_dateTime)),
            Text("${DateFormat.Hms().format(_dateTime)} Hrs."),
          ],
        ),
      ),
    );
  }
}
