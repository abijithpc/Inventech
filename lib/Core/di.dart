import 'package:get_it/get_it.dart';
import 'package:inventech/Login_page/data/DataSource/user_local_datasource.dart';
import 'package:inventech/Login_page/data/RepositoryImpl/login_repositoryimpl.dart';
import 'package:inventech/Login_page/domain/Repository/login_repository.dart';
import 'package:inventech/Login_page/domain/Usecase/login_user.dart';
import 'package:inventech/Login_page/domain/Usecase/logout_usecase.dart';
import 'package:inventech/Login_page/presentation/Bloc/login_bloc.dart';
import 'package:inventech/Splash_Screen/presentation/Bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 🔹 Bloc
  sl.registerFactory(() => SplashBloc());
  sl.registerFactory(() => AuthBloc(sl(), sl()));

  //DataSource
  sl.registerLazySingleton(() => UserLocalDatasource());

  ///UseCase
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));

  //Repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryimpl(sl()));

  // Add other dependencies here when needed
  // e.g., sl.registerLazySingleton(() => SomeUseCase(sl()));
  // e.g., sl.registerLazySingleton<SomeRepository>(() => SomeRepositoryImpl(sl()));
}
