import 'package:flutter/material.dart';

import '../screen/style/palatte.dart';
//import '../palatte.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    required this.controller,
    required this.obscureText,
  });
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[600]?.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16)
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  vertical:20
              ),
              border: InputBorder.none,
              hintText: hint,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  icon,color: Colors.white,
                  size: 30,
                ),
              ),
              hintStyle: kBodyText),
          style: kBodyText,
          keyboardType: inputType,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}
