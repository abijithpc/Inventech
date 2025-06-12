import 'package:inventech/Product_Page/data/Model/product_model.dart';
import 'package:inventech/Product_Page/domain/product_Repository/product_repository.dart';

class AddProductUseCase {
  final ProductRepository repository;

  AddProductUseCase(this.repository);

  Future<void> call(ProductModel product) {
    return repository.addProduct(product);
  }
}
