
import 'package:firstapp/screen/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Model/cart_items.dart';
import '../Model/cart_repository.dart';
import 'cart_ingredient_card.dart';

class Cart extends StatefulWidget {
  final CartRepository cart;
  Cart({required this.cart });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double totalPrice = 0.0;
  late List<CartItem> cartItems =[];

  @override
  void initState() {
    super.initState();
    cartItems=[];
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    cartItems = await widget.cart.getCartItems();
    _calculateTotalPrice();
  }
  void _calculateTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in cartItems) {
      double price = cartItem.price;
      int quantity = cartItem.quantity;
      total += price * quantity;
    }

    setState(() {
      totalPrice = total;
    });
  }

  Future<void> _deleteIngredient(String ingre_id)async{
    await widget.cart.deleteIngredient(ingre_id);
    await _fetchCartItems();
  }
  Future<void> _decreaseIngredientQuantity(String ingre_id, int quantity) async{
    await widget.cart.decreaseIngredientQuantity(ingre_id,quantity);
    await _fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        title: const Text('My Cart'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text(
              'INGREDIENTS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('PRICE', style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 20,),
                Text('QUANTITY', style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                CartItem cartItem = cartItems[index];
                return CartIngredientCard(
                  name: cartItem.name,
                  price: cartItem.price,
                  quantity: cartItem.quantity,
                  onDecrease: () {
                    _decreaseIngredientQuantity(cartItem.ingre_id,cartItem.quantity);
                  },
                   /*onDelete: () {
                    _deleteIngredient(cartItem.id);
                  },*/
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Total Price: \Rs$totalPrice',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Text('Checkout'),
                        content: const Text('Do you want to checkout?'),
                        actions: [
                          TextButton(
                              onPressed: (){},
                              child: const Text('Yes')),
                          TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close')
                          )
                        ],
                      );
                    }
                );
              },
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
