//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/View/recipe_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../Model/recipe.dart';
import '../viewModel/FavoriteRepository.dart';
import '../viewModel/RecipeCardViewModel.dart';
import 'recipecard.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  final FavoriteRepository favoriteRepository = FavoriteRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: favoriteRepository.getFavoriteRecipesStream(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Text('No favorite recipes found.');
          }
          //List<Recipe> recipes = snapshot.data! as List<Recipe>;
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  Map<String, dynamic>? recipeData = document.data() as Map<String, dynamic>?;
                  if (recipeData == null) {
                    // Handle the case when the recipe data is missing or null
                    return const SizedBox.shrink(); // or display an appropriate widget
                  }
                  Recipe recipe = Recipe(
                    recipe_id: document.id,
                    name: recipeData['name'] ?? '',
                    cookTime: recipeData['cookTime'] ?? '',
                    rating: recipeData['rating'] ?? 0,
                    image: recipeData['image'] ?? '',
                    category_id: recipeData['category_id'] ?? '',
                  );
                  RecipeCardViewModel viewModel = RecipeCardViewModel(recipe: recipe);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailPage(
                            recipeId: recipe.recipe_id, recipe: recipe,
                          ),
                        ),
                      );
                    },
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (c)async{
                              print('delete');
                              await favoriteRepository.deleteRecipe(snapshot.data!.docs[index].id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Recipe deleted from favorites'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            spacing: 8,
                          )
                        ],
                      ),
                      child: RecipeCard(
                        viewModel: viewModel,
                      ),
                    ),
                  );
                }
          );
        },
      )
    );
  }

}

