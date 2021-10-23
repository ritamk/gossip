import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gossip/models/food.dart';
import 'package:gossip/models/order.dart';
import 'package:gossip/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToCartButtons extends StatefulWidget {
  const AddToCartButtons({Key? key, required this.food}) : super(key: key);
  final Food food;

  @override
  _AddToCartButtonsState createState() => _AddToCartButtonsState();
}

class _AddToCartButtonsState extends State<AddToCartButtons> {
  int _qty = 1;
  bool _addToCartLoading = false;
  final String _addToCartKey = "add_to_cart_button";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
                children: widget.food.discPrice != null
                    ? <InlineSpan>[
                        const TextSpan(
                            text: "₹",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.red)),
                        TextSpan(text: " ${widget.food.discPrice.toString()} "),
                        TextSpan(
                          text: widget.food.price.toString(),
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.redAccent.shade700,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ]
                    : <InlineSpan>[
                        const TextSpan(
                            text: "₹",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.red)),
                        TextSpan(text: " ${widget.food.price.toString()}"),
                      ],
              ),
            ),
            // Change quantity button
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      onPressed: () => reduceQty(),
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 0.0, width: 4.0),
                  Text(
                    _qty.toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 0.0, width: 4.0),
                  IconButton(
                      onPressed: () => increaseQty(),
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15.0, width: 0.0),
        // Add to cart button
        InkWell(
          onTap: () async => await addToCart(context)
              .then((value) => setState(() => _addToCartLoading = false)),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: !_addToCartLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 0.0,
                        width: 8.0,
                      ),
                      Text(
                        "Add to Cart",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : const Loading(color: Colors.white),
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

  Future<void> addToCart(BuildContext context) async {
    setState(() => _addToCartLoading = true);
    final sharedPref = await SharedPreferences.getInstance();
    final Future<bool> stringSet;

    final List<CartLocalData> cartLocalData = [
      CartLocalData(foodID: widget.food.foodId, qty: _qty.toString())
    ];
    List<CartLocalData> previousData = [];

    try {
      if (sharedPref.getString(_addToCartKey)?.isNotEmpty ?? false) {
        jsonDecode(sharedPref.getString(_addToCartKey).toString()).forEach(
            (json) =>
                previousData += [CartLocalData.fromJson(json)] + cartLocalData);

        stringSet =
            sharedPref.setString(_addToCartKey, jsonEncode(previousData));
      } else {
        stringSet =
            sharedPref.setString(_addToCartKey, jsonEncode(cartLocalData));
      }
      stringSet.whenComplete(() => setState(() {
            _addToCartLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Item has been added to cart successfully.",
                textAlign: TextAlign.center,
              ),
            ));
          }));
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Something went wrong, Item could not be added.",
            textAlign: TextAlign.center,
          ),
        ));
      });
    }
  }
}
