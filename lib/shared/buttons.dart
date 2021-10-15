import 'package:flutter/material.dart';

BoxDecoration authButtonDecoration() {
  return BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(30.0),
  );
}

BoxDecoration authTextContainerDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    color: Colors.grey.shade300,
  );
}

InputDecoration authTextInputDecoration(String label, IconData suffixIcon) {
  return InputDecoration(
    prefixIcon: Icon(suffixIcon),
    labelText: label,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    errorBorder: InputBorder.none,
  );
}
