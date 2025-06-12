import 'package:inventech/Product_Page/data/Model/product_model.dart';

abstract class ProductRepository {
  Future<void> addProduct(ProductModel product);
  Future<List<ProductModel>> getAllProducts();
  Future<void> deleteProducts(int id);
  Future<void> updateProduct(ProductModel product);
}
