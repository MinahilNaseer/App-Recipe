
import 'package:firstapp/View/recipe_detail_page.dart';
import 'package:flutter/material.dart';
//import '../Domain/recipe.dart';
//import '../firebase/recipe_dinner_firebase.dart';
import '../Model/recipe.dart';
import '../viewModel/RecipeCardViewModel.dart';
import '../viewModel/recipe_repository.dart';
import 'recipecard.dart';
import '../screen/style/color.dart';

class Dinner extends StatefulWidget {
  const Dinner({Key? key}) : super(key: key);

  @override
  State<Dinner> createState() => _DinnerState();
}

class _DinnerState extends State<Dinner> {
  final RecipeRepository _recipeRepository = RecipeRepository();
  @override
  void initState() {
    super.initState();
    _recipeRepository.createDinnerCollection();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: maincolor,
        title: const Text('Dinner Recipes'),
      ),
      body: FutureBuilder<List<Recipe>>(
          future: _recipeRepository.getRecipesByDinnerCategory('mLa6t97rrD9H2mRL10US', 'Dinner'),
          builder: (BuildContext context,AsyncSnapshot<List<Recipe>> snapshot){
            if( snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }else if(snapshot.hasError){
              return Text('Error: ${snapshot.error}');
            }else{
              List<Recipe> recipes = snapshot.data!;
              return ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (BuildContext context,index){
                      Recipe recipe = recipes[index];
                      RecipeCardViewModel viewModel = RecipeCardViewModel(recipe: recipe);
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailPage(recipe: recipe, recipeId: recipe.recipe_id,),
                            ),
                          );
                        },
                        child: RecipeCard(
                          viewModel: viewModel,
                        ),
                      );
                    }
                );
            }
          }
      ),
    );
  }
}

