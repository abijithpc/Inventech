import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventech/Product_Page/domain/Usecase/deletproduct_usecase.dart';
import 'package:inventech/Product_Page/domain/Usecase/getallproduct_usecase.dart';
import 'package:inventech/Product_Page/domain/Usecase/product_usecase.dart';
import 'package:inventech/Product_Page/domain/Usecase/updateproduct_usecase.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_event.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddProductUseCase addProductUseCase;
  final GetAllProductsUseCase getAllProductsUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final UpdateproductUsecase updateproductUsecase;

  ProductBloc(
    this.addProductUseCase,
    this.getAllProductsUseCase,
    this.deleteProductUseCase,
    this.updateproductUsecase,
  ) : super(ProductInitial()) {
    on<AddProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        print("Adding Product: ${event.product.name}");
        print("AddProductEvent triggered with: ${event.product.toMap()}");

        await addProductUseCase(event.product);
        emit(ProductSuccess());
      } catch (e) {
        emit(ProductFailure("Failed to Add product : ${e.toString()}"));
      }
    });
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getAllProductsUseCase();
        emit(ProductSuccess());
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductFailure('Failed to load products: $e'));
      }
    });
    on<DeleteProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        await deleteProductUseCase(event.productId);
        final updatedProducts = await getAllProductsUseCase();
        emit(ProductLoaded(updatedProducts));
      } catch (e) {
        emit(ProductFailure("Message: ${e.toString()}"));
      }
    });
    on<UpdateProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        await updateproductUsecase(event.product);
        final products = await getAllProductsUseCase();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductFailure('Failed to Update the product : ${e.toString()}'));
      }
    });
  }
}
