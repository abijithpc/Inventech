import 'package:inventech/Login_page/domain/Repository/login_repository.dart';
import 'package:inventech/Login_page/domain/entity/user_entity.dart';

class LoginUser {
  final LoginRepository repository;

  LoginUser(this.repository);

  Future<bool> call(UserEntity user) {
    return repository.login(user);
  }
}
