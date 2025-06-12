import 'package:inventech/Product_Page/data/Model/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {}

class ProductFailure extends ProductState {
  final String message;

  ProductFailure(this.message);
}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  ProductLoaded(this.products);
}
