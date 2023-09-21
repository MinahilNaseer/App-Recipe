import 'package:cloud_firestore/cloud_firestore.dart';

class PopularCategory {
  final String name;
  final String iconUrl;

  PopularCategory({required this.name, required this.iconUrl});

  factory PopularCategory.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return PopularCategory(
      name: data['name'],
      iconUrl: data['iconUrl'],
    );
  }
}