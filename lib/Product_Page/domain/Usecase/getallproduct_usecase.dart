import 'package:inventech/Product_Page/data/Model/product_model.dart';
import 'package:inventech/Product_Page/domain/product_Repository/product_repository.dart';

class GetAllProductsUseCase {
  final ProductRepository repository;

  GetAllProductsUseCase(this.repository);

  Future<List<ProductModel>> call() {
    return repository.getAllProducts();
  }
}
