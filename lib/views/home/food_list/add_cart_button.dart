import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/services/providers.dart';
import 'package:gossip/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({Key? key, required this.foodID}) : super(key: key);
  final String foodID;

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _addToCartLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return InkWell(
          onTap: () async => await addToCart(context, ref),
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
        );
      },
    );
  }

  Future<void> addToCart(BuildContext context, ScopedReader ref) async {
    setState(() => _addToCartLoading = true);
    final sharedPref = await SharedPreferences.getInstance();

    try {
      await sharedPref
          .setString(
              widget.foodID, ref(changeCartFoodQuantity).state.toString())
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
