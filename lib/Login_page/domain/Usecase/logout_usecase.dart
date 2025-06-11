import 'package:inventech/Login_page/domain/Repository/login_repository.dart';

class LogoutUsecase {
  final LoginRepository repository;

  LogoutUsecase(this.repository);

  Future<void> call() async {
    return await repository.logout();
  }
}
