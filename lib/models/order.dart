import 'package:cloud_firestore/cloud_firestore.dart';

class OrderData {
  OrderData({
    required this.name,
    required this.item,
    required this.qty,
    required this.price,
    this.time,
    this.delivery,
  });

  final String name;
  final String item;
  final int qty;
  final int price;
  final Timestamp? time;
  final bool? delivery;
}

class CartData {
  CartData({
    required this.item,
    required this.qty,
    required this.name,
    required this.price,
    this.discPrice,
    this.image,
  });

  final String item;
  final String name;
  final int price;
  final String qty;
  final int? discPrice;
  final String? image;
}
