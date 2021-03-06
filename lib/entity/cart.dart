import 'package:floor/floor.dart';

@entity
class Cart {
  @primaryKey
  final int id;

  final String uid, name, category, imageUrl, price;

  int quantity;

  Cart(
      {this.id,
      this.uid,
      this.name,
      this.category,
      this.imageUrl,
      this.price,
      this.quantity});
}
