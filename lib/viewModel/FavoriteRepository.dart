import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteRepository {
  String? getCurrentUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email;
    } else {
      // User is not logged in
      return '';
    }
  }

  Future<void> deleteRecipe(String id) async {
    await FirebaseFirestore.instance
        .collection('Favorite')
        .doc(getCurrentUserEmail())
        .collection('recipe')
        .doc(id)
        .delete();
  }

  Stream<QuerySnapshot> getFavoriteRecipesStream() {
    return FirebaseFirestore.instance
        .collection('Favorite')
        .doc(getCurrentUserEmail())
        .collection('recipe')
        .snapshots();
  }
}