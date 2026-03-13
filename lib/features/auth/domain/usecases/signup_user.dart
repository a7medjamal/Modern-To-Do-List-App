
import 'package:cat_to_do_list/features/auth/domain/repositories/auth_repo.dart';

class SignUpUser {
  final AuthRepository repo;
  SignUpUser(this.repo);
  Future<void> call(String email, String password) {
    return repo.signUp(email: email, password: password);
  }
}
