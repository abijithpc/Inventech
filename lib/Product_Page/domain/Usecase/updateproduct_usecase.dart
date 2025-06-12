import 'package:inventech/Product_Page/data/Model/product_model.dart';
import 'package:inventech/Product_Page/domain/product_Repository/product_repository.dart';

class UpdateproductUsecase {
  final ProductRepository repository;

  UpdateproductUsecase(this.repository);

  Future<void> call(ProductModel products) {
    return repository.updateProduct(products);
  }
}
