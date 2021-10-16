import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddInfoDialog extends StatelessWidget {
  const AddInfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoAlertDialog(
      title: Text("Guide to adding food items"),
      content: Text(
        "1. Name, Price, Veg and Type are required.\n"
        "2. Type will always be in small-case.\n"
        "3. Veg is a boolean, so its value will be either \"true\" or \"false\".\n"
        "4. To indicate no discount is available, leave the field blank.",
        softWrap: true,
      ),
    );
  }
}
