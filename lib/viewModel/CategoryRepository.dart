import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepository {
  final CollectionReference<Map<String, dynamic>> _categoryCollection =
  FirebaseFirestore.instance.collection('Category');

  Stream<QuerySnapshot<Map<String, dynamic>>> getCategoryStream() {
    return _categoryCollection.snapshots();
  }
}