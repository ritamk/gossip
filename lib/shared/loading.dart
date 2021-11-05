import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, required this.white}) : super(key: key);
  final bool white;

  @override
  Widget build(BuildContext context) {
    return white
        ? Theme(
            data: ThemeData.dark(), child: const CupertinoActivityIndicator())
        : Theme(
            data: ThemeData.fallback(),
            child: const CupertinoActivityIndicator());
  }
}
