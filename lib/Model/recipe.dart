import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Recipe{
  final String recipe_id;
  final String name;
  final int rating;
  final String cookTime;
  final String image;
  final String category_id;
  Recipe(
      {
        required this.category_id,
        required this.recipe_id,
        required this.rating,
        required this.cookTime,
        required this.image,
        required this.name,
      }
      );
  factory Recipe.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Recipe(
      recipe_id: snapshot.id,
      name: data['name'] ?? '',
      category_id: data['category_id'] ?? '',
      rating: data['rating'] ?? '',
      cookTime: data['cookTime'] ?? '',
      image: data['image'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category_id': category_id,
      'recipe_id': recipe_id,
      'rating': rating,
      'cookTime': cookTime,
      'image': image,
    };
  }

  // Create a Recipe object from a Map
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      name: map['name'],
      category_id: map['category_id'],
      recipe_id: map['recipe_id'],
      rating: map['rating'],
      cookTime: map['cookTime'],
      image: map['image'],
    );
  }
}