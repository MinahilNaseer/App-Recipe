import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Model/Category.dart';
import '../viewModel/CategoryRepository.dart';
import 'category_card.dart';

class CategoryList extends StatefulWidget {
  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  final CategoryRepository _categoryRepository = CategoryRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
            'Category',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'ro'
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:10),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream:  _categoryRepository.getCategoryStream(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              final categories = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context,index){
                    final categoryData = categories[index].data();
                    final category = CategoryModel(
                      image: categoryData['image'],
                      name: categoryData['name'],
                    );
                    return CategoryCard(
                      category: category
                    );
                  }
              );
            },
          )
        ),
      ),
    );
  }
}
