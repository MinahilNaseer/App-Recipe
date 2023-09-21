import 'package:cloud_firestore/cloud_firestore.dart';
//import '../Domain/recipe.dart';
import '../Model/recipe.dart';

class RecipeRepository {
  final CollectionReference _recipesCollection =
  FirebaseFirestore.instance.collection('Recipe');
  final CollectionReference _breakfastCollection =
  FirebaseFirestore.instance.collection('BreakfastRecipes');
  final CollectionReference _lunchCollection =
  FirebaseFirestore.instance.collection('LunchRecipes');
  final CollectionReference _dinnerCollection =
  FirebaseFirestore.instance.collection('DinnerRecipes');

  Future<void> createBreakfastCollection() async {
    final QuerySnapshot querySnapshot = await _recipesCollection
        .where('category_id', isEqualTo: 'HCg58eruSJFzRSttefqk')
        .get();

    final List<QueryDocumentSnapshot> breakfastRecipes =
        querySnapshot.docs;

    for (final recipeSnapshot in breakfastRecipes) {
      final Map<String, dynamic> recipeData = recipeSnapshot.data() as Map<String, dynamic>;
      final Recipe recipe = Recipe.fromMap(recipeData);
      final QuerySnapshot existingRecipes = await _breakfastCollection
          .where('recipe_id', isEqualTo: recipe.recipe_id)
          .get();

      if (existingRecipes.docs.isEmpty) {
        await _breakfastCollection.add(recipe.toMap());
      }
    }
  }
  Future<void> createLunchCollection() async {
    final QuerySnapshot querySnapshot = await _recipesCollection
        .where('category_id', isEqualTo: 'c7IwNMZiQKzKaAJrDnca')
        .get();

    final List<QueryDocumentSnapshot> lunchRecipes =
        querySnapshot.docs;

    for (final recipeSnapshot in lunchRecipes) {
      final Map<String, dynamic> recipeData = recipeSnapshot.data() as Map<String, dynamic>;
      final Recipe recipe = Recipe.fromMap(recipeData);
      final QuerySnapshot existingRecipes = await _lunchCollection
          .where('recipe_id', isEqualTo: recipe.recipe_id)
          .get();

      if (existingRecipes.docs.isEmpty) {
        await _lunchCollection.add(recipe.toMap());
      }
    }
  }
  Future<void> createDinnerCollection() async {
    final QuerySnapshot querySnapshot = await _recipesCollection
        .where('category_id', isEqualTo: 'mLa6t97rrD9H2mRL10US')
        .get();

    final List<QueryDocumentSnapshot> dinnerRecipes =
        querySnapshot.docs;

    for (final recipeSnapshot in dinnerRecipes) {
      final Map<String, dynamic> recipeData = recipeSnapshot.data() as Map<String, dynamic>;
      final Recipe recipe = Recipe.fromMap(recipeData);
      final QuerySnapshot existingRecipes = await _dinnerCollection
          .where('recipe_id', isEqualTo: recipe.recipe_id)
          .get();

      if (existingRecipes.docs.isEmpty) {
        await _dinnerCollection.add(recipe.toMap());
      }
    }
  }
  Future<List<Recipe>> getRecipesByBreakfastCategory(
      String categoryId, String categoryName) async {
    final QuerySnapshot querySnapshot = await _breakfastCollection.get();

    final List<QueryDocumentSnapshot> recipeSnapshots = querySnapshot.docs;
    final List<Recipe> recipes = [];

    for (final recipeSnapshot in recipeSnapshots) {
      final Map<String, dynamic> recipeData =
      recipeSnapshot.data() as Map<String, dynamic>;
      final Recipe recipe = Recipe.fromMap(recipeData);
      recipes.add(recipe);
    }

    return recipes;
  }

  Future<List<Recipe>> getRecipesByLunchCategory(
      String categoryId, String categoryName) async {
    final QuerySnapshot querySnapshot = await _lunchCollection.get();

    final List<QueryDocumentSnapshot> recipeSnapshots = querySnapshot.docs;
    final List<Recipe> recipes = [];

    for (final recipeSnapshot in recipeSnapshots) {
      final Map<String, dynamic> recipeData =
      recipeSnapshot.data() as Map<String, dynamic>;
      final Recipe recipe = Recipe.fromMap(recipeData);
      recipes.add(recipe);
    }
    return recipes;
  }
  Future<List<Recipe>> getRecipesByDinnerCategory(
      String categoryId, String categoryName) async {
    final QuerySnapshot querySnapshot = await _dinnerCollection.get();

    final List<QueryDocumentSnapshot> recipeSnapshots = querySnapshot.docs;
    final List<Recipe> recipes = [];

    for (final recipeSnapshot in recipeSnapshots) {
      final Map<String, dynamic> recipeData =
      recipeSnapshot.data() as Map<String, dynamic>;
      final Recipe recipe = Recipe.fromMap(recipeData);
      recipes.add(recipe);
    }
    return recipes;
  }

  Future<List<Recipe>> getRecipes() async {
    var data = await FirebaseFirestore.instance.collection('Recipe').orderBy('name').get();
    return data.docs.map((doc) => Recipe.fromSnapshot(doc)).toList();
  }

}