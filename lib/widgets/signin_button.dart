import 'dart:ffi';

import 'package:flutter/material.dart';

class SignInButtons extends StatelessWidget {
  const SignInButtons({
    super.key,
    required this.buttonName,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });
  final String buttonName;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
            enableFeedback: false,
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: onPressed,
            child: Text(
              buttonName,
              style: TextStyle(
                  fontSize: 18,
                color: textColor,
              ),
            ),
        )
    );
  }
}