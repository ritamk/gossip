import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip/models/food.dart';
import 'package:gossip/views/add_food/add_info_dialog.dart';
import 'package:gossip/services/database.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  bool _veg = false;
  String _type = "";
  int? _discPrice;
  double? _rating;
  String? _about;
  String? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Food"),
        actions: <Widget>[
          IconButton(
              color: Colors.red,
              onPressed: () => Navigator.of(context).push(CupertinoDialogRoute(
                  builder: (builder) => const AddInfoDialog(),
                  context: context)),
              icon: const Icon(Icons.info))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
                onChanged: (val) => _name = val,
                validator: (val) => val!.isEmpty ? "Name required" : null,
              ),
              const SizedBox(
                height: 10.0,
                width: 0.0,
              ),
              // Veg or not
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Veg",
                ),
                onChanged: (val) {
                  _veg = (val == "true") ? true : false;
                },
                validator: (val) => val!.isEmpty ? "true/false required" : null,
              ),
              const SizedBox(
                height: 10.0,
                width: 0.0,
              ),
              // Type
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Type",
                ),
                onChanged: (val) => _type = val,
              ),
              const SizedBox(
                height: 10.0,
                width: 0.0,
              ),
              // About
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "About",
                ),
                onChanged: (val) => _about = val,
              ),
              const SizedBox(
                height: 10.0,
                width: 0.0,
              ),
              // Price
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Price",
                ),
                onChanged: (val) => _price = int.parse(val),
                validator: (val) => val!.isEmpty ? "Price required" : null,
              ),
              const SizedBox(
                height: 10.0,
                width: 0.0,
              ),
              // Rating
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Rating",
                ),
                onChanged: (val) => _rating = double.parse(val),
              ),
              const SizedBox(
                height: 10.0,
                width: 0.0,
              ),
              // Discount Price
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Discount Price",
                ),
                onChanged: (val) => _discPrice = int.parse(val),
              ),
              const SizedBox(
                height: 10.0,
                width: 0.0,
              ),
              // Image
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Image",
                ),
                onChanged: (val) => _image = val,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await DatabaseService()
                .addFoodItem(Food(
              name: _name,
              price: _price,
              veg: _veg,
              type: _type,
              about: _about,
              image: _image,
              discPrice: _discPrice,
              discPer: _discPrice != null
                  ? (((_price - _discPrice!.toInt()) / _discPrice!.toInt()) *
                          100)
                      .round()
                  : null,
              rating: _rating,
              foodId: "",
            ))
                .then((value) {
              Navigator.of(context).pop();
              setState(() {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Item added successfully.")));
              });
            });
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
