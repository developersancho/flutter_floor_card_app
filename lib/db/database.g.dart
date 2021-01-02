// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CartDao _cartDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Cart` (`id` INTEGER, `uid` TEXT, `name` TEXT, `category` TEXT, `imageUrl` TEXT, `price` TEXT, `quantity` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CartDao get cartDao {
    return _cartDaoInstance ??= _$CartDao(database, changeListener);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _cartInsertionAdapter = InsertionAdapter(
            database,
            'Cart',
            (Cart item) => <String, dynamic>{
                  'id': item.id,
                  'uid': item.uid,
                  'name': item.name,
                  'category': item.category,
                  'imageUrl': item.imageUrl,
                  'price': item.price,
                  'quantity': item.quantity
                },
            changeListener),
        _cartUpdateAdapter = UpdateAdapter(
            database,
            'Cart',
            ['id'],
            (Cart item) => <String, dynamic>{
                  'id': item.id,
                  'uid': item.uid,
                  'name': item.name,
                  'category': item.category,
                  'imageUrl': item.imageUrl,
                  'price': item.price,
                  'quantity': item.quantity
                },
            changeListener),
        _cartDeletionAdapter = DeletionAdapter(
            database,
            'Cart',
            ['id'],
            (Cart item) => <String, dynamic>{
                  'id': item.id,
                  'uid': item.uid,
                  'name': item.name,
                  'category': item.category,
                  'imageUrl': item.imageUrl,
                  'price': item.price,
                  'quantity': item.quantity
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Cart> _cartInsertionAdapter;

  final UpdateAdapter<Cart> _cartUpdateAdapter;

  final DeletionAdapter<Cart> _cartDeletionAdapter;

  @override
  Stream<List<Cart>> getAllItemInCartByUid(String uid) {
    return _queryAdapter.queryListStream('Select * from Cart Where uid=?',
        arguments: <dynamic>[uid],
        queryableName: 'Cart',
        isView: false,
        mapper: (Map<String, dynamic> row) => Cart(
            id: row['id'] as int,
            uid: row['uid'] as String,
            name: row['name'] as String,
            category: row['category'] as String,
            imageUrl: row['imageUrl'] as String,
            price: row['price'] as String,
            quantity: row['quantity'] as int));
  }

  @override
  Stream<List<Cart>> getItemInCartByUid(String uid, String id) {
    return _queryAdapter.queryListStream(
        'Select * from Cart Where uid=? and id=?',
        arguments: <dynamic>[uid, id],
        queryableName: 'Cart',
        isView: false,
        mapper: (Map<String, dynamic> row) => Cart(
            id: row['id'] as int,
            uid: row['uid'] as String,
            name: row['name'] as String,
            category: row['category'] as String,
            imageUrl: row['imageUrl'] as String,
            price: row['price'] as String,
            quantity: row['quantity'] as int));
  }

  @override
  Stream<List<Cart>> clearCartByUid(String uid) {
    return _queryAdapter.queryListStream('Delete * from Cart Where uid=?',
        arguments: <dynamic>[uid],
        queryableName: 'Cart',
        isView: false,
        mapper: (Map<String, dynamic> row) => Cart(
            id: row['id'] as int,
            uid: row['uid'] as String,
            name: row['name'] as String,
            category: row['category'] as String,
            imageUrl: row['imageUrl'] as String,
            price: row['price'] as String,
            quantity: row['quantity'] as int));
  }

  @override
  Future<void> insertCart(Cart cart) async {
    await _cartInsertionAdapter.insert(cart, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCart(Cart cart) async {
    await _cartUpdateAdapter.update(cart, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCart(Cart cart) async {
    await _cartDeletionAdapter.delete(cart);
  }
}
