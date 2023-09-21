
import 'package:firstapp/View/profile.dart';
import 'package:firstapp/View/search.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'category.dart';
import '../screen/style/color.dart';
import 'favorite.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) => Search()
            )
        );
          },
        backgroundColor: maincolor,
        child: const Icon(Icons.search),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => Home()
                        )
                    );
                  },
                child: const Icon(
                  Icons.home,
                   size: 27,
                  color: Colors.amber,
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => CategoryList()
                    )
                );},
                child: const Icon(
                  Icons.category,
                  size: 27,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => Favorite()
                    )
                );
                  },
                child: const Icon(
                  Icons.favorite,
                  size: 27,
                  color: Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => Profile()
                      )
                  );
                },
                child: const Icon(
                  Icons.person,
                  size: 27,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      body: const Home(),
    );
  }
}
