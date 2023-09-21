
import 'package:flutter/material.dart';

import '../Model/popular_categories.dart';
import '../Model/recipe.dart';
import '../viewModel/HomePageService.dart';
import '../viewModel/MealTypeCard.dart';
import '../viewModel/recipecard_popular.dart';
import 'recipe_detail_page.dart';
import '../screen/style/color.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: background,
        appBar: AppBar(
          title: const Text(
              'Foodie',
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'ro'
            ),
          ),
          elevation: 0,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/image.png'),
              ),
            )
          ],
          backgroundColor: maincolor,
        ),
        body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15),
                  child: Text(
                    'Popular Category',
                    style: TextStyle(
                      fontSize: 20,
                      color: font,
                      fontFamily: 'ro',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    height: 150,
                    child: FutureBuilder<List<PopularCategory>>(
                      future: firestoreService.getPopularCategories(),
                      builder: (BuildContext context, AsyncSnapshot<List<PopularCategory>> snapshot){
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        List<PopularCategory> categories = snapshot.data ?? [];
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return MealTypeCard(
                                Icon: categories[index].iconUrl,
                                name: categories[index].name
                            );
                          },
                        );
                      },
                    )
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15),
                  child: Text(
                    'Popular Recipes',
                    style: TextStyle(
                        fontSize: 20,
                        color: font,
                        fontFamily: 'ro',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
            child: SizedBox(
                height: 400,
                child: FutureBuilder<List<Recipe>>(
                  future: firestoreService.getPopularRecipes(),
                  builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot){
                    if(snapshot.hasError){
                      return const Text('Error loading popular recipes');
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No popular recipes found');
                    }
                    List<Recipe> recipes = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: recipes.length,
                        itemBuilder: (context,index){
                          Recipe recipe = recipes[index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailPage(recipe: recipe, recipeId: recipe.recipe_id,),
                                ),
                              );
                            },
                            child: RecipeCardPopular(
                              recipe: Recipe(
                                  category_id: recipe.category_id,
                                  recipe_id: recipe.recipe_id,
                                  rating: recipe.rating,
                                  cookTime: recipe.cookTime,
                                  image: recipe.image,
                                  name: recipe.name
                              ),
                            ),
                          );
                        }
                    );
                  },
                )
              ),
            ),
        ]
        )
    );
  }
}
