import 'package:flutter/material.dart';
import 'package:gossip/models/food.dart';
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
                // boxShadow: <BoxShadow>[
                //   BoxShadow(
                //     color: Colors.black45.withOpacity(0.5),
                //     offset: const Offset(0.0, 1.0),
                //     blurRadius: 7.0,
                //   ),
                // ],
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
          onTap: () async => await addToCart(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            decoration: BoxDecoration(
              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //     color: Colors.red.withOpacity(0.5),
              //     offset: const Offset(0.0, 1.0),
              //     blurRadius: 7.0,
              //   ),
              // ],
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

    try {
      await sharedPref
          .setString(widget.food.foodId, _qty.toString())
          .whenComplete(() => setState(() {
                _addToCartLoading = false;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "Item has been added to cart successfully.",
                    textAlign: TextAlign.center,
                  ),
                ));
              }));
    } catch (e) {
      print(e.toString());
      setState(() {
        _addToCartLoading = false;
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
