import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_floor_card_app/dao/cart_dao.dart';
import 'package:flutter_floor_card_app/db/database.dart';
import 'package:flutter_floor_card_app/model/product.dart';
import 'package:flutter_floor_card_app/widget/product_card.dart';
import 'package:flutter/services.dart' as rootBundle;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder("cart.db").build();
  final dao = database.cartDao;

  runApp(MyApp(dao: dao));
}

class MyApp extends StatelessWidget {
  final CartDao dao;
  MyApp({this.dao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: "Card", dao: dao),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.dao}) : super(key: key);
  final String title;
  final CartDao dao;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: readJsonData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                children: List.generate(snapshot.data.length, (index) {
                  return Center(
                    child: ProductCard(
                        cartDao: widget.dao, product: snapshot.data[index]),
                  );
                }),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<Product>> readJsonData() async {
    final rawData = await rootBundle.rootBundle
        .loadString("assets/data/my_product_json.json");
    final list = json.decode(rawData) as List<dynamic>;
    return list.map((model) => Product.fromJson(model)).toList();
  }
}
