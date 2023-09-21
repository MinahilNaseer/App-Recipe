import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartIngredientCard extends StatefulWidget {

  final String name;
  final double price;
  final int quantity;
  final Function() onDecrease;
  //final Function() onIncrease;
  const CartIngredientCard({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.onDecrease,
    //required this.onIncrease
  });
  @override
  State<CartIngredientCard> createState() => _CartIngredientCardState();
}

class _CartIngredientCardState extends State<CartIngredientCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 30,),
          Expanded(
              child: Text(
                  widget.name,
                style: const TextStyle(
                  fontSize: 20
                ),
              )
          ),
          Text(
              '${widget.price}',
            style: const TextStyle(
              fontSize: 17
            ),
          ),
          const SizedBox(width: 30,),
          IconButton(
              onPressed: widget.onDecrease,
              icon: const Icon(Icons.remove_circle)
          ),
          Text(
              '${widget.quantity}',
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          /*IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: widget.onIncrease,
          ),*/
    ]
      ),
    );
  }
}
