import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return (color == Colors.white)
        ? Theme(
            data: ThemeData.dark(), child: const CupertinoActivityIndicator())
        : Theme(
            data: ThemeData.fallback(),
            child: const CupertinoActivityIndicator());
  }
}
