import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final TextStyle buttonTextStyle;
  const TextButtonWidget(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      required this.buttonTextStyle});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: buttonTextStyle,
      ),
    );
  }
}
