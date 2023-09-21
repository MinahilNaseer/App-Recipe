
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldSignin extends StatelessWidget {
  const TextFieldSignin({
    super.key,
    required this.hint,
    required this.obscureText,
    required this.controller

  });
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
              color: Colors.white
          ),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )
          )
      ),
    );
  }
}