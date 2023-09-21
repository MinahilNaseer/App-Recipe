import 'package:flutter/material.dart';
import '../View/breakfast.dart';
import '../View/dinner.dart';
import '../View/lunch.dart';

class MealTypeCard extends StatelessWidget {
  final String Icon;
  final String name;
  MealTypeCard({
    required this.Icon,
    required this.name});

  void _navigateToCategory(BuildContext context) {
    if (name == 'Breakfast') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Breakfast()),
      );
    } else if (name == 'Lunch') {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Lunch()),
      );
    } else if (name == 'Dinner') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dinner()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> _navigateToCategory(context),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
        ),
        width: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              Icon,
              color: Colors.blueGrey,
              fit: BoxFit.cover,
            ),
            Text(
              name,
              style:
                  const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600
                  ),
            )
          ],
        ),
      ),
    );
  }
}
