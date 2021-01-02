import 'package:floor/floor.dart';
import 'package:flutter_floor_card_app/dao/cart_dao.dart';
import 'package:flutter_floor_card_app/entity/cart.dart';

// need imports
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // generate code

@Database(version: 1, entities: [Cart])
abstract class AppDatabase extends FloorDatabase {
  CartDao get cartDao;
}
