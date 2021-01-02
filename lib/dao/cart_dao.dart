import 'package:floor/floor.dart';
import 'package:flutter_floor_card_app/entity/cart.dart';

@dao
abstract class CartDao {
  @Query("Select * from Cart Where uid=:uid")
  Stream<List<Cart>> getAllItemInCartByUid(String uid);

  @Query("Select * from Cart Where uid=:uid and id=:id")
  Stream<List<Cart>> getItemInCartByUid(String uid, String id);

  @Query("Delete * from Cart Where uid=:uid")
  Stream<List<Cart>> clearCartByUid(String uid);

  @insert
  Future<void> insertCart(Cart cart);

  @update
  Future<void> updateCart(Cart cart);

  @delete
  Future<void> deleteCart(Cart cart);
}
