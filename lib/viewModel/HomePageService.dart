
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/popular_categories.dart';
import '../Model/recipe.dart';

class FirestoreService{
  final CollectionReference<Map<String, dynamic>> recipesCollection =
  FirebaseFirestore.instance.collection('Recipe');
  final CollectionReference<Map<String, dynamic>> popularRecipesCollection =
  FirebaseFirestore.instance.collection('TopRecipes');
  final CollectionReference popularCategoriesCollection =
  FirebaseFirestore.instance.collection('homecategory');
  Future<List<PopularCategory>> getPopularCategories() async {
    final snapshot = await popularCategoriesCollection.get();
    return snapshot.docs.map((document) => PopularCategory.fromSnapshot(document)).toList();
  }

  Future<List<Recipe>> getPopularRecipes() async {
    final snapshot = await recipesCollection.orderBy('rating', descending: true).limit(4).get();
    return snapshot.docs.map((document) => Recipe.fromSnapshot(document)).toList();
  }
}