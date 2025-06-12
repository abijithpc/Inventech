import 'package:get_it/get_it.dart';
import 'package:inventech/Login_page/data/DataSource/user_local_datasource.dart';
import 'package:inventech/Login_page/data/RepositoryImpl/login_repositoryimpl.dart';
import 'package:inventech/Login_page/domain/Repository/login_repository.dart';
import 'package:inventech/Login_page/domain/Usecase/login_user.dart';
import 'package:inventech/Login_page/domain/Usecase/logout_usecase.dart';
import 'package:inventech/Login_page/presentation/Bloc/login_bloc.dart';
import 'package:inventech/Product_Page/data/Datasource/product_local_datasource.dart';
import 'package:inventech/Product_Page/data/Product_RepositoryImpl/product_repositoryimpl.dart';
import 'package:inventech/Product_Page/domain/Usecase/deletproduct_usecase.dart';
import 'package:inventech/Product_Page/domain/Usecase/getallproduct_usecase.dart';
import 'package:inventech/Product_Page/domain/Usecase/product_usecase.dart';
import 'package:inventech/Product_Page/domain/Usecase/updateproduct_usecase.dart';
import 'package:inventech/Product_Page/domain/product_Repository/product_repository.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_bloc.dart';
import 'package:inventech/Splash_Screen/presentation/Bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 🔹 Bloc
  sl.registerFactory(() => SplashBloc());
  sl.registerFactory(() => AuthBloc(sl(), sl()));
  sl.registerFactory(() => ProductBloc(sl(), sl(), sl(), sl()));

  //DataSource
  sl.registerLazySingleton(() => UserLocalDatasource());
  sl.registerLazySingleton(() => ProductLocalDatasource());

  ///UseCase
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => AddProductUseCase(sl()));
  sl.registerLazySingleton(() => GetAllProductsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(sl()));
  sl.registerLazySingleton(() => UpdateproductUsecase(sl()));

  //Repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryimpl(sl()));
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryimpl(sl()),
  );

  // Add other dependencies here when needed
  // e.g., sl.registerLazySingleton(() => SomeUseCase(sl()));
  // e.g., sl.registerLazySingleton<SomeRepository>(() => SomeRepositoryImpl(sl()));
}
