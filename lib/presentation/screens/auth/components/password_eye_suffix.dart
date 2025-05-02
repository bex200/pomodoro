import 'package:flutter/material.dart';

Widget? fieldInputDecoration(bool isObscure, VoidCallback onPressed) {
  return IconButton(
    icon: Icon(
      isObscure ? Icons.visibility_off : Icons.visibility,
      size: 20,
    ),
    onPressed: onPressed,
  );
}
