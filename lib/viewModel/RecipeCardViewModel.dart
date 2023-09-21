import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

//import '../Domain/recipe.dart';
import '../Model/recipe.dart';

class RecipeCardViewModel extends ChangeNotifier {
  Recipe recipe;
  int count = 0;

  RecipeCardViewModel({required this.recipe});

  void incrementCounter() {
    count++;
    notifyListeners();
  }

  Future<void> addToFavorite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('Favorite');
    return _collectionRef
        .doc(currentUser!.email)
        .collection('recipe')
        .doc()
        .set({
      'name':recipe.name,
      'cookTime':recipe.cookTime,
      'image':recipe.image,
      'rating':recipe.rating
    }).then((value) => print('Added to favorite'));
    notifyListeners();
  }
}