import 'package:flutter/material.dart';
import 'package:gossip/models/food.dart';

class FoodListTile extends StatefulWidget {
  const FoodListTile({Key? key, required this.food}) : super(key: key);
  final Food food;

  @override
  State<FoodListTile> createState() => _FoodListTileState();
}

class _FoodListTileState extends State<FoodListTile>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // Device measurements to help with drawing the food image.
    final double width = MediaQuery.of(context).size.width / 2.0;
    final double maxWidth = width / 0.8;

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
          "${widget.food.name}",
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
                bottomLeft: Radius.elliptical(width, 40.0),
                bottomRight: Radius.elliptical(width, 40.0),
              ),
              image: DecorationImage(
                image: NetworkImage(widget.food.image ??
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
                "${widget.food.about}",
                style: const TextStyle(fontSize: 16.0, color: Colors.black87),
              ),
              const SizedBox(
                height: 15.0,
                width: 0.0,
              ),
              // Displays the "price" of the Food item.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                      children: <InlineSpan>[
                        const TextSpan(
                            text: "₹",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.red)),
                        TextSpan(text: " ${widget.food.price.toString()}"),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.red.withOpacity(0.4),
                            offset: const Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
