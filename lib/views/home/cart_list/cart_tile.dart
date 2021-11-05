import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gossip/models/order.dart';
import 'package:gossip/views/home/cart_list/order_button.dart';

class CartTile extends StatelessWidget {
  const CartTile({Key? key, required this.cartData, required this.uid})
      : super(key: key);
  final CartData cartData;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cartData.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        RichText(
                          text: cartData.discPrice != null
                              ? TextSpan(
                                  style: const TextStyle(
                                      fontSize: 18.0, color: Colors.black87),
                                  children: <InlineSpan>[
                                    const TextSpan(
                                        text: "₹ ",
                                        style: TextStyle(fontSize: 16.0)),
                                    TextSpan(
                                        text:
                                            "${cartData.discPrice.toString()}\t"),
                                    TextSpan(
                                        text: cartData.price.toString(),
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough)),
                                  ],
                                )
                              : TextSpan(
                                  style: const TextStyle(
                                      fontSize: 18.0, color: Colors.black87),
                                  children: <InlineSpan>[
                                    const TextSpan(
                                        text: "₹ ",
                                        style: TextStyle(fontSize: 16.0)),
                                    TextSpan(text: cartData.price.toString()),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
                CartTileOrderButton(cartData: cartData, uid: uid),
              ],
            ),
          ),
          // Image
          Container(
            constraints: BoxConstraints.tight(const Size.square(80.0)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              image: DecorationImage(
                image: NetworkImage(cartData.image ??
                    "https://assets.materialup.com/uploads/b03b23aa-aa69-4657-aa5e-fa5fef2c76e8/preview.png"),
                fit: BoxFit.cover,
                onError: (object, stacktrace) =>
                    SizedBox.expand(child: Container(color: Colors.black87)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Image
//               Container(
//                 constraints: BoxConstraints.tight(const Size.square(80.0)),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25.0),
//                   image: DecorationImage(
//                     image: NetworkImage(cartData.image ??
//                         "https://assets.materialup.com/uploads/b03b23aa-aa69-4657-aa5e-fa5fef2c76e8/preview.png"),
//                     fit: BoxFit.cover,
//                     onError: (object, stacktrace) => SizedBox.expand(
//                         child: Container(color: Colors.black87)),
//                   ),
//                 ),
//               ),