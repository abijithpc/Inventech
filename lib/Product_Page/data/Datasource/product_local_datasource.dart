import 'dart:async';

import 'package:inventech/Product_Page/data/Model/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductLocalDatasource {
  static Future<Database> get database async {
    final path = join(await getDatabasesPath(), 'product_database.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, brand TEXT, model TEXT, description TEXT, images TEXT, createdAt TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<List<ProductModel>> getProducts() async {
    final db = await database;
    final maps = await db.query('products');

    return maps.map((map) {
      return ProductModel(
        id: map['id'] as int?,
        name: map['name'] as String,
        brand: map['brand'] as String,
        model: map['model'] as String,
        description: map['description'] as String,
        images: (map['images'] as String).split(','),
        createdAt: DateTime.now(),
      );
    }).toList();
  }

  Future<void> addProduct(ProductModel product) async {
    final db = await database;
    await db.insert('products', {
      'name': product.name,
      'brand': product.brand,
      'model': product.model,
      'description': product.description,
      'images': product.images.join(','),
      'createdAt': product.createdAt.toIso8601String(), 
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateProduct(ProductModel product) async {
    final db = await database;
    await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
    print("Updating product with ID: ${product.id}");
  }

  Future<void> deleteProducts(int id) async {
    final db = await database;
    await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
}
