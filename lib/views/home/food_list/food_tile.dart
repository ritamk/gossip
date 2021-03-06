import 'package:flutter/material.dart';
import 'package:gossip/models/food.dart';
import 'package:gossip/views/home/food_list/add_cart_buttons.dart';

class FoodListTile extends StatelessWidget {
  const FoodListTile({Key? key, required this.food}) : super(key: key);
  final Food food;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 8.0),
        title:
            // Displays the name of the Food item.
            Text(
          food.name,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        children: <Widget>[
          // Food image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              image: DecorationImage(
                image: NetworkImage(food.image ??
                    "https://assets.materialup.com/uploads/b03b23aa-aa69-4657-aa5e-fa5fef2c76e8/preview.png"),
                fit: BoxFit.cover,
                onError: (object, stacktrace) =>
                    SizedBox.expand(child: Container(color: Colors.black87)),
              ),
            ),
            height: 200.0,
            width: double.infinity,
          ),
          const SizedBox(
            height: 15.0,
            width: 0.0,
          ),
          Column(
            children: <Widget>[
              // Displays the "about" info of the Food item.
              Text(
                "${food.about}",
                style: const TextStyle(fontSize: 16.0, color: Colors.black87),
              ),
              const SizedBox(
                height: 15.0,
                width: 0.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Veg or not
                  RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: food.veg
                                ? Colors.green.shade800
                                : Colors.red.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                          text: food.veg ? "Veg" : "Non-veg",
                        ),
                        const TextSpan(
                            text: "\t\t\t???\t\t\t",
                            style: TextStyle(
                                color: Colors.black38, fontSize: 12.0)),
                        TextSpan(
                          text: food.rating.toString(),
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.black87),
                        ),
                        TextSpan(
                          text: " ???",
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.yellow.shade700),
                        ),
                      ],
                    ),
                  ),
                  // Discount percentage
                  Text(
                    food.discPer != null
                        ? "${food.discPer.toString()}% off!"
                        : "",
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
                width: 0.0,
              ),
              // Displays the "price" of the Food item.
              AddToCartButtons(food: food),
            ],
          ),
        ],
      ),
    );
  }
}
