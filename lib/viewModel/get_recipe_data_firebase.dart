import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/recipe.dart';

class GetRecipeDataFirebase {
  final CollectionReference recipeCollection =
  FirebaseFirestore.instance.collection('Recipes');

  Future<List<Recipe>> getRecipes() async {
    QuerySnapshot snapshot = await recipeCollection.get();
    List<Recipe> recipes = [];

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Recipe recipe = Recipe(
        recipe_id: doc.id,
        name: data['name'],
        image: data['image'],
        rating: data['rating'],
        cookTime: data['cookTime'],
        category_id: data['category_id'],
      );
      recipes.add(recipe);
    });

    return recipes;
  }

  Future<Recipe?> getRecipeById(String recipeId) async {
    DocumentSnapshot snapshot = await recipeCollection.doc(recipeId).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      Recipe recipe = Recipe(
        recipe_id: snapshot.id,
        name: data['name'],
        image: data['image'],
        rating: data['rating'],
        cookTime: data['cookTime'],
        category_id: data['category_id'],
      );
      return recipe;
    }

    return null;
  }
}