import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventech/Login_page/domain/Usecase/login_user.dart';
import 'package:inventech/Login_page/domain/Usecase/logout_usecase.dart';
import 'package:inventech/Login_page/domain/entity/user_entity.dart';
import 'package:inventech/Login_page/presentation/Bloc/login_event.dart';
import 'package:inventech/Login_page/presentation/Bloc/login_state.dart';

class AuthBloc extends Bloc<LoginEvent, AuthState> {
  final LoginUser loginUser;
  final LogoutUsecase logoutUsecase;

  AuthBloc(this.loginUser, this.logoutUsecase) : super(AuthInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        final isValid = await loginUser(
          UserEntity(email: event.email, password: event.password),
        );

        if (isValid) {
          emit(AuthSuccess());
        } else {
          emit(AuthFailure("Invalid email or password"));
        }
      } catch (e) {
        emit(AuthFailure("Login error: ${e.toString()}"));
      }
    });
    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await logoutUsecase();
        emit(LoggedOut());
      } catch (e) {
        emit(AuthFailure('Logout Failed :${e.toString()}'));
      }
    });
  }
}
