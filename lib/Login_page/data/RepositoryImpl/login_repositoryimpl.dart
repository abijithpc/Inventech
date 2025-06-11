import 'package:inventech/Login_page/data/DataSource/user_local_datasource.dart';
import 'package:inventech/Login_page/domain/Repository/login_repository.dart';
import 'package:inventech/Login_page/domain/entity/user_entity.dart';

class LoginRepositoryimpl extends LoginRepository {
  final UserLocalDatasource datasource;

  LoginRepositoryimpl(this.datasource);

  @override
  Future<bool> login(UserEntity user) {
    return datasource.validateUser(user.email, user.password);
  }

  @override
  Future<void> logout() {
    return datasource.logout();
  }
}
