import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget categoriesContainer({required String image,required String name}){
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(left: 8),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image),fit: BoxFit.cover,
          ),
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      const SizedBox(height:10 ,),
      Text(
        name,
        style: const TextStyle(
            fontSize: 20,
            color: Colors.black),
      )
    ],
  );
}