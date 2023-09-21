
import 'package:firstapp/View/recipe_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Model/recipe.dart';
import '../viewModel/RecipeCardViewModel.dart';
import '../viewModel/recipe_repository.dart';
import 'recipecard.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List searchResults = [];
  List result = [];
  final TextEditingController _searchController = TextEditingController();
  RecipeRepository _recipeRepository = RecipeRepository();

  @override
  void initState(){
    _searchController.addListener(_onSearchChanged);
    super.initState();
    getRecipeStream();
  }
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
 /* @override
  void didChangeDependencies() {
    getRecipeStream();
    super.didChangeDependencies();
  }
  */
  void _onSearchChanged() {
    print(_searchController.text);
    searchResultList();
    //searchRecipes();
  }

  void searchResultList() {
    var showResult = [];
    if (_searchController.text != '') {
      for (var recipe in searchResults) {
        var name = recipe.name.toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResult.add(recipe);
        }
      }
    } else {
      showResult = List.from(searchResults);
    }
    setState(() {
      result = showResult;
    });
    //searchResultList();
  }

  void navigateToRecipeDetail(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailPage(
          recipe: recipe,
          recipeId: recipe.recipe_id,
        ),
      ),
    );
  }
  Future<void> getRecipeStream()async{
    var recipes =await _recipeRepository.getRecipes();
    setState(() {
      searchResults = recipes;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CupertinoSearchTextField(
            controller: _searchController,
            backgroundColor: Colors.white,
          ),
        ),
      body: ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          RecipeCardViewModel viewModel = RecipeCardViewModel(recipe: result[index]);
          return GestureDetector(
            onTap: () {
              navigateToRecipeDetail(result[index]);
            },
            child: RecipeCard(
              viewModel: viewModel,
            ),
          );
        },
      ),
    );
  }
}
