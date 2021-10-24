import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gossip/models/food.dart';

class OrderData {
  OrderData({
    required this.food,
    required this.qty,
    required this.time,
  });

  final Food food;
  int qty;
  final Timestamp time;
}

class FetchOrderData {
  FetchOrderData({
    required this.item,
    required this.price,
    required this.qty,
    required this.name,
    required this.time,
  });

  final DocumentReference item;
  final int price;
  final int qty;
  final String name;
  final Timestamp time;
}
