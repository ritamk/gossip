import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/services/providers.dart';

class ChangeQuantityButton extends StatefulWidget {
  const ChangeQuantityButton({Key? key}) : super(key: key);

  @override
  _ChangeQuantityButtonState createState() => _ChangeQuantityButtonState();
}

class _ChangeQuantityButtonState extends State<ChangeQuantityButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Consumer(
        builder: (context, ref, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  onPressed: () => reduceQty(ref),
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  )),
              const SizedBox(height: 0.0, width: 4.0),
              Text(
                ref(changeCartFoodQuantity).state.toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 0.0, width: 4.0),
              IconButton(
                  onPressed: () => increaseQty(ref),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ],
          );
        },
      ),
    );
  }

  void increaseQty(ScopedReader ref) {
    if (ref(changeCartFoodQuantity).state < 25) {
      setState(() => ref(changeCartFoodQuantity).state++);
    }
  }

  void reduceQty(ScopedReader ref) {
    if (ref(changeCartFoodQuantity).state > 1) {
      setState(() => ref(changeCartFoodQuantity).state--);
    }
  }
}
