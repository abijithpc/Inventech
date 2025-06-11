import 'package:inventech/Login_page/domain/entity/user_entity.dart';

abstract class LoginRepository {
  Future<bool> login(UserEntity user);
  Future<void> logout();
}
