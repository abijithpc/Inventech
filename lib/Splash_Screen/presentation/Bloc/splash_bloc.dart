import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventech/Splash_Screen/presentation/Bloc/splash_event.dart';
import 'package:inventech/Splash_Screen/presentation/Bloc/splash_state.dart';
import 'package:inventech/Core/DB_Helper/db_helper.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<StartSplashAnimation>(_onStartSplashAnimation);
  }

  Future<void> _onStartSplashAnimation(
    StartSplashAnimation event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    emit(const SplashAnimated());

    await Future.delayed(const Duration(seconds: 2));

    final db = await DBHelper.database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: ['admin@inventech.com', 'admin@123'],
    );

    if (result.isNotEmpty) {
      emit(const NavigateToHome());
    } else {
      emit(const NavigateToLogin());
    }
  }
}
