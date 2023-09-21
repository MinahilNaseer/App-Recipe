//import 'dart:js';

//import 'dart:js';

//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Model/recipe.dart';
import '../screen/style/color.dart';
import '../viewModel/get_recipe_data_firebase.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  final String recipeId;

  RecipeDetailPage({required this.recipe, required this.recipeId});
  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final GetRecipeDataFirebase recipeData = GetRecipeDataFirebase();
  @override
  Future<void> addToCart(String ingre_id) async {
    // Reference to the Firestore collections
    CollectionReference ingredientsCollection =
        FirebaseFirestore.instance.collection('Ingredients');
    CollectionReference cartCollection =
        FirebaseFirestore.instance.collection('Cart');

    // Get the ingredient document from the ingredients collection
    DocumentSnapshot ingredientSnapshot =
        await ingredientsCollection.doc(ingre_id).get();

    if (ingredientSnapshot.exists) {
      // Ingredient exists, get its data
      Map<String, dynamic> ingredientData =
          ingredientSnapshot.data() as Map<String, dynamic>;

      // Check if the ingredient already exists in the cart
      DocumentSnapshot cartSnapshot = await cartCollection.doc(ingre_id).get();

      if (cartSnapshot.exists) {
        // Ingredient already exists in the cart, update the quantity
        int currentQuantity = cartSnapshot['quantity'];
        await cartCollection.doc(ingre_id).update({
          'quantity': currentQuantity + 1,
        });
      } else {
        // Ingredient doesn't exist in the cart, add it with quantity 1
        ingredientData['quantity'] = 1;
        await cartCollection.doc(ingre_id).set(ingredientData);
      }

      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ingredient added to cart!'),
        ),
      );
    } else {
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ingredient does not exist!'),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(slivers: [
            SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                expandedHeight: 400,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    widget.recipe.image,
                    fit: BoxFit.cover,
                  ),
                ),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(10),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(70),
                              topRight: Radius.circular(70)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 80,
                            height: 4,
                            color: font,
                          )
                        ],
                      ),
                    )
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(250, 250, 250, 0.6),
                      radius: 18,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: font,
                        ),
                      )
                  ),
                )
            ),
            SliverToBoxAdapter(
              child: Wrap(
                children: [
                  Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 40,
                              height: 33,
                              child: const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 35,
                              ),
                            ),
                            Container(
                              width: 33,
                              height: 33,
                              child: const Icon(
                                Icons.schedule,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 58.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.recipe.rating}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.redAccent,
                                  fontFamily: 'ro',
                                ),
                              ),
                              Text(
                                widget.recipe.cookTime,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.redAccent,
                                  fontFamily: 'ro',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Text(
                                'Ingredients',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: font,
                                    fontFamily: 'ro',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Ingredients')
                                .where('recipe_id', isEqualTo: widget.recipe.recipe_id)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<DocumentSnapshot> documents =
                                    snapshot.data!.docs;
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: documents.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> ingredient =
                                          documents[index].data()
                                              as Map<String, dynamic>;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                addToCart(
                                                    ingredient['ingre_id']);
                                              },
                                              icon: Container(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.amber),
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 24,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ingredient['name'],
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            Text('${ingredient['price']}'),
                                          ],
                                        ),
                                      );
                                    });
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Text(
                                'Directions',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: font,
                                    fontFamily: 'ro',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Description')
                                .where('recipe_id', isEqualTo: widget.recipe.recipe_id)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<DocumentSnapshot> documents =
                                    snapshot.data!.docs;
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: documents.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> description =
                                          documents[index].data()
                                              as Map<String, dynamic>;
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          description['des'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'ro',
                                          ),
                                        ),
                                      );
                                    });
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ]
                      )
                  )
                ],
              ),
            ),
          ]
          ),
        )
    );
  }
}
