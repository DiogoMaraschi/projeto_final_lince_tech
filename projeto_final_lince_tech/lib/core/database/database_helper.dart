import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // BRANDS
    await db.execute('''
      CREATE TABLE brands (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        deleted_at TEXT
      )
    ''');

    // ADDRESSES
    await db.execute('''
      CREATE TABLE addresses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        state TEXT NOT NULL,
        city TEXT NOT NULL,
        zip_code TEXT NOT NULL,
        street TEXT NOT NULL,
        number TEXT NOT NULL,
        neighborhood TEXT,
        complement TEXT,
        latitude REAL,
        longitude REAL
      )
    ''');

    // PRODUCTS
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        barcode TEXT NOT NULL UNIQUE,
        description TEXT,
        brand_id INTEGER NOT NULL,
        image_path TEXT,
        deleted_at TEXT,

        FOREIGN KEY (brand_id)
          REFERENCES brands(id)
      )
    ''');

    // CUSTOMERS
    await db.execute('''
      CREATE TABLE customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        cnpj TEXT NOT NULL UNIQUE,
        legal_name TEXT NOT NULL,
        phone TEXT,
        email TEXT,
        establishment_type TEXT,
        address_id INTEGER NOT NULL,
        deleted_at TEXT,

        FOREIGN KEY (address_id)
          REFERENCES addresses(id)
      )
    ''');

    // CARRIERS
    await db.execute('''
      CREATE TABLE carriers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        legal_name TEXT NOT NULL,
        cnpj TEXT NOT NULL UNIQUE,
        email TEXT,
        phone TEXT,
        cost_per_km REAL NOT NULL,
        minimum_price REAL NOT NULL,
        address_id INTEGER,
        deleted_at TEXT,

        FOREIGN KEY (address_id)
          REFERENCES addresses(id)
      )
    ''');

    // ORDERS
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_id INTEGER NOT NULL,
        carrier_id INTEGER,
        order_number TEXT NOT NULL UNIQUE,
        payment_method TEXT NOT NULL,
        installments INTEGER DEFAULT 1,
        total_price REAL NOT NULL,
        order_date TEXT NOT NULL,
        delivery_date TEXT,
        delivery_distance REAL,
        delivery_notes TEXT,
        payment_notes TEXT,
        deleted_at TEXT,

        FOREIGN KEY (customer_id)
          REFERENCES customers(id),

        FOREIGN KEY (carrier_id)
          REFERENCES carriers(id)
      )
    ''');

    // ORDER ITEMS
    await db.execute('''
      CREATE TABLE order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        unit_price REAL NOT NULL,

        FOREIGN KEY (order_id)
          REFERENCES orders(id),

        FOREIGN KEY (product_id)
          REFERENCES products(id)
      )
    ''');

    // STORE SETTINGS
    await db.execute('''
      CREATE TABLE store_settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        legal_name TEXT NOT NULL,
        trade_name TEXT,
        logo_path TEXT,
        cnpj TEXT NOT NULL UNIQUE,
        address_id INTEGER NOT NULL,

        FOREIGN KEY (address_id)
          REFERENCES addresses(id)
      )
    ''');
  }

  // CLOSE DATABASE
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
