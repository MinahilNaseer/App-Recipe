
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../viewModel/RecipeCardViewModel.dart';


class RecipeCard extends StatelessWidget {
  final RecipeCardViewModel viewModel;

  const RecipeCard({required this.viewModel});

  @override


  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.9),
              offset: const Offset(0.0, 10.0,),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            ),
          ],
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.35),
              BlendMode.multiply,
            ),
            image: NetworkImage(viewModel.recipe.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 50),
                child: Text(
                  viewModel.recipe.name,
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Favorite')
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection('recipe').where('name',isEqualTo: viewModel.recipe.name).snapshots(),
              builder: (BuildContext context,AsyncSnapshot snapshot){
                if(snapshot.data==null){
                  return Text('');
                }
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: Color.fromRGBO(250, 250, 250, 0.4),
                      radius: 18,
                      child: IconButton(
                          onPressed: () {
                            if (snapshot.data.docs.length == 0) {
                              viewModel.addToFavorite();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to Favorites'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Already Added to Favorites'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          icon: snapshot.data.docs.length==0  ? const Icon(
                            Icons.favorite_outline,
                            color: Colors.black,
                            size: 25,
                          ):const Icon(
                            Icons.favorite,
                            color: Colors.white,
                          )
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          '${viewModel.recipe.rating}',
                          style: const TextStyle(
                              color: Colors.white60
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        const SizedBox(width: 7),
                        Text(
                            viewModel.recipe.cookTime,
                          style: const TextStyle(
                            color: Colors.white60
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
  }
}