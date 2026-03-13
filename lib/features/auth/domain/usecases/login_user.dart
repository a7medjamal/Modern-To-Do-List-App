
import 'package:cat_to_do_list/features/auth/domain/repositories/auth_repo.dart';

class LoginUser {
  final AuthRepository repo;

  LoginUser(this.repo);

  Future<void> call(String email, String password) {
    return repo.login(email: email, password: password);
  }
}
