import 'cart_items.dart';

abstract class CartRepository {
  Future<void> clearCart();
  Future<List<CartItem>> getCartItems();
  Future<double> calculateTotalPrice();
  Future<void> deleteIngredient(String ingreId);
  Future<void> decreaseIngredientQuantity(String ingreId,int quantity);
}