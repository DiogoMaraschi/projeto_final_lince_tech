// await db.execute(TableCarrier.createTable);
// TODO TROCAR IMPLEMENTACAO DO BANCO DE DADOS

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _databaseName = 'app_database.db';
  static const int _databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        barcode TEXT,
        description TEXT,
        brand TEXT,
        image_path TEXT,
        deleted_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE carriers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        legal_name TEXT,
        cnpj TEXT UNIQUE,
        phone TEXT,
        email TEXT,
        cost_per_km REAL NOT NULL,
        minimum_price REAL NOT NULL,
        deleted_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        cnpj TEXT NOT NULL UNIQUE,
        legal_name TEXT NOT NULL,
        phone TEXT,
        email TEXT,
        establishment_type TEXT NOT NULL,

        state TEXT NOT NULL,
        city TEXT NOT NULL,
        zip_code TEXT NOT NULL,
        street TEXT NOT NULL,
        number TEXT NOT NULL,

        latitude REAL NOT NULL,
        longitude REAL NOT NULL,

        deleted_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE store_settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,

        name TEXT NOT NULL,
        legal_name TEXT,
        cnpj TEXT,

        phone TEXT,
        email TEXT,

        state TEXT,
        city TEXT,
        zip_code TEXT,
        street TEXT,
        number TEXT,

        latitude REAL,
        longitude REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_id INTEGER NOT NULL,
        carrier_id INTEGER NOT NULL,
        payment_method TEXT NOT NULL,
        installments INTEGER NOT NULL,
        discount REAL NOT NULL DEFAULT 0,
        freight REAL NOT NULL DEFAULT 0,
        notes TEXT,
        created_at TEXT NOT NULL,
        deleted_at TEXT,

        FOREIGN KEY (customer_id)
          REFERENCES customers(id),

        FOREIGN KEY (carrier_id)
          REFERENCES carriers(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        quantity REAL NOT NULL,
        unit_price REAL NOT NULL,
        discount REAL NOT NULL DEFAULT 0,

        FOREIGN KEY (order_id)
          REFERENCES orders(id),

        FOREIGN KEY (product_id)
          REFERENCES products(id)
      )
    ''');
  }

  Future<void> resetDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    await _database?.close();
    _database = null;

    print('banco resetado');

    await deleteDatabase(path);
  }
}
