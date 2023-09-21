import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget bottomContainer({required String image,required int price,required String name}){
  return Container(
    height: 270,
    width: 220,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(image),
        ),
        ListTile(
          leading: Text(
            name,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white),
          ),
          trailing: Text(
            '\$ $price',
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white),
          ),
        ),
      ],
    ),
  );
}