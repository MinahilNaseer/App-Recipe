import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/cart_items.dart';
import '../Model/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CollectionReference cartCollection =
  FirebaseFirestore.instance.collection('Cart');
  late final CartRepository repository;

  @override
  Future<List<CartItem>> getCartItems() async {
    QuerySnapshot cartSnapshot = await cartCollection.get();
    List<QueryDocumentSnapshot> cartItems = cartSnapshot.docs;

    // Convert QueryDocumentSnapshots to CartItems
    List<CartItem> items = cartItems.map((snapshot) {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      return CartItem(
        ingre_id: snapshot.id,
        name: data['name'],
          price : double.parse(data['price'].toString()),
        quantity : int.parse(data['quantity'].toString())
      );
    }).toList();

    return items;
  }
  @override
  Future<double> calculateTotalPrice() async {
    List<CartItem> cartItems = await repository.getCartItems();

    double total = 0.0;
    for (CartItem cartItem in cartItems) {
      double price = double.parse(cartItem.price as String).toString() as double;
      int quantity = int.parse(cartItem.quantity as String).toString() as int;
      total += price * quantity;
    }
    return total;
  }
  @override
  Future<void> deleteIngredient(String ingre_id) async {
    await cartCollection.doc(ingre_id).delete();
  }

  @override
  Future<void> decreaseIngredientQuantity(String ingre_id,int quantity) async {
    final DocumentSnapshot itemSnapshot = await cartCollection.doc(ingre_id).get();
    if (itemSnapshot.exists) {
      final Map<String, dynamic> itemData = itemSnapshot.data() as Map<String, dynamic>;
      final int currentQuantity = itemData['quantity'] as int;

      if (currentQuantity > 1) {
        await cartCollection.doc(ingre_id).update({'quantity': currentQuantity - 1});
      } else {
        await cartCollection.doc(ingre_id).delete();
      }
    }
  }
  @override
  Future<void> clearCart() async {
    QuerySnapshot cartSnapshot =
    await FirebaseFirestore.instance.collection('Cart').get();
    List<QueryDocumentSnapshot> cartItems = cartSnapshot.docs;
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (var cartItem in cartItems) {
      batch.delete(cartItem.reference);
    }
    await batch.commit();
  }
}