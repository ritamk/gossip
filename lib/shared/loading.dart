import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 0.0,
      heightFactor: 0.0,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 6.0,
      ),
    );
  }
}
