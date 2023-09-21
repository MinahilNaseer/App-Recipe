import 'package:flutter/material.dart';

class PopularRecipe{
  final String name;
  final String image;
  final int rating;
  final String time;
  PopularRecipe(
      {required this.name, required this.image, required this.rating,required this.time});
}