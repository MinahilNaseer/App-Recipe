

class Ingredient{
  final String name;
  final String recipe_id;
  final String ingre_id;
  final int price;
  Ingredient(
      {
        required this.recipe_id,
        required this.ingre_id,
        required this.name,
        required this.price,
      }
      );
}