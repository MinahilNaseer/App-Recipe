//import 'package:firstapp/Domain/recipe.dart';
import 'package:flutter/material.dart';

import '../Model/recipe.dart';
//import '../Domain/recipe.dart';

class RecipeCardPopular extends StatefulWidget {
  final Recipe recipe;
  RecipeCardPopular({
    required this.recipe,
   });

  @override
  State<RecipeCardPopular> createState() => _RecipeCardPopularState();
}

class _RecipeCardPopularState extends State<RecipeCardPopular> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 170,
          child: Image.network(
              widget.recipe.image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            width: 160,
            height: 90,
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipe.name,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  widget.recipe.cookTime,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                        Icons.star,
                      size: 20,
                        color: Colors.amber,
                    ),
                    Text(
                      '${widget.recipe.rating}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
