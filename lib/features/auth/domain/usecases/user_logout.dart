
import 'package:cat_to_do_list/features/auth/domain/repositories/auth_repo.dart';

class LogoutUser {
  final AuthRepository repository;

  LogoutUser(this.repository);

  Future<void> call() async {
    return await repository.logout();
  }
}
