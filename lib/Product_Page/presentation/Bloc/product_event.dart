import 'package:inventech/Product_Page/data/Model/product_model.dart';

abstract class ProductEvent {}

class AddProductEvent extends ProductEvent {
  final ProductModel product;

  AddProductEvent(this.product);
}

class LoadProductsEvent extends ProductEvent {}

class DeleteProductEvent extends ProductEvent {
  final int productId;

  DeleteProductEvent(this.productId);
}

class UpdateProductEvent extends ProductEvent {
  final ProductModel product;
  UpdateProductEvent(this.product);
}
