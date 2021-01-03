import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floor_card_app/const/const.dart';
import 'package:flutter_floor_card_app/dao/cart_dao.dart';
import 'package:flutter_floor_card_app/entity/cart.dart';
import 'package:flutter_floor_card_app/model/product.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key key, this.cartDao, this.product}) : super(key: key);
  final Product product;
  final CartDao cartDao;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Column(
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.fill,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  "${product.name}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: int.parse(product.oldPrice) == 0
                                ? ''
                                : '\$${product.oldPrice}',
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough)),
                        TextSpan(text: "${product.price}"),
                      ]),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var cardProduct =
                            await cartDao.getItemInCartByUid(UID, product.id);
                        if (cardProduct != null) {
                          cardProduct.quantity += 1;
                          await cartDao.updateCart(cardProduct);
                        } else {
                          Cart card = Cart(
                              id: product.id,
                              price: product.price,
                              category: product.category,
                              imageUrl: product.imageUrl,
                              quantity: 1,
                              name: product.name,
                              uid: UID);
                          await cartDao.updateCart(card);
                        }
                      },
                      child: Icon(Icons.shopping_cart),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
