
import 'package:firstapp/View/recipe_detail_page.dart';
//import 'package:firstapp/Presentation/recipe_detail_page.dart';
import 'package:flutter/material.dart';
import '../Model/recipe.dart';
import '../viewModel/RecipeCardViewModel.dart';
import '../viewModel/recipe_repository.dart';
import 'recipecard.dart';
import '../screen/style/color.dart';

class Breakfast extends StatefulWidget {
  const Breakfast({Key? key}) : super(key: key);

  @override
  State<Breakfast> createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {

  final RecipeRepository _recipeRepository = RecipeRepository();
  @override
  void initState() {
    super.initState();
    _recipeRepository.createBreakfastCollection();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: maincolor,
        title: const Text('Breakfast Recipes'),
      ),
      body: FutureBuilder<List<Recipe>>(
          future: _recipeRepository.getRecipesByBreakfastCategory('HCg58eruSJFzRSttefqk', 'Breakfast'),
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

