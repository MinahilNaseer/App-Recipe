import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen/style/palatte.dart';
//import '../palatte.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });
  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(40)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10.0,
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
              buttonText,
              style: kBodyText),
        ),
      ),
    );
  }
}