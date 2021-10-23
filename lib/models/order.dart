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

class CartLocalData {
  CartLocalData({
    required this.foodID,
    required this.qty,
  });

  String foodID = "";
  String qty = "0";

  Map<String, dynamic> toJson() {
    return {
      "foodID": foodID,
      "qty": qty,
    };
  }

  factory CartLocalData.fromJson(Map<String, dynamic> json) {
    return CartLocalData(
      foodID: json["foodID"],
      qty: json["qty"],
    );
  }
}
