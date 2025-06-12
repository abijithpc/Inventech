import 'package:inventech/Product_Page/data/Datasource/product_local_datasource.dart';
import 'package:inventech/Product_Page/data/Model/product_model.dart';
import 'package:inventech/Product_Page/domain/product_Repository/product_repository.dart';

class ProductRepositoryimpl implements ProductRepository {
  final ProductLocalDatasource datasource;

  ProductRepositoryimpl(this.datasource);

  @override
  Future<void> addProduct(ProductModel product) {
    return datasource.addProduct(product);
  }

  @override
  Future<List<ProductModel>> getAllProducts() {
    return datasource.getProducts();
  }

  @override
  Future<void> deleteProducts(int id) => datasource.deleteProducts(id);

  @override
  Future<void> updateProduct(ProductModel product) {
    return datasource.updateProduct(product);
  }
}
