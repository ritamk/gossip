// ignore_for_file: file_names
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
        subtitle: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black54, fontSize: 18.0),
            children: <InlineSpan>[
              const TextSpan(text: "₹ ", style: TextStyle(fontSize: 15.0)),
              TextSpan(text: orderData.price.toString()),
              const TextSpan(
                  text: "\t\t\t●\t\t\t", style: TextStyle(fontSize: 15.0)),
              TextSpan(text: orderData.qty.toString()),
            ],
          ),
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
