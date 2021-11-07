import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderHelpDialog extends StatelessWidget {
  const OrderHelpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoAlertDialog(
      title: Text("Search usage:"),
      content: Text("Tap on the search text-field, "
          "enter the item you are searching for, "
          "if the item exists, it'll be displayed "
          "otherwise the loading animation will keep playing."),
    );
  }
}
