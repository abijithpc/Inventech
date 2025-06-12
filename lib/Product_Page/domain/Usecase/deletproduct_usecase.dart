// domain/usecases/delete_product_usecase.dart
import 'package:inventech/Product_Page/domain/product_Repository/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  Future<void> call(int id) => repository.deleteProducts(id);
}
