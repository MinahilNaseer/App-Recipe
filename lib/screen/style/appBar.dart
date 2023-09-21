import 'package:flutter/material.dart';
import 'color.dart';

PreferredSizeWidget appbar() {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    title: const Icon(
      Icons.menu,
      size: 27,
    ),
    actions: const [
      Padding(
        padding: EdgeInsets.only(right: 20),
      ),
    ],
    backgroundColor: maincolor,
  );
}