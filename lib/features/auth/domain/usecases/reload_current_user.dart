import 'package:cat_to_do_list/features/auth/domain/repositories/auth_repo.dart';

class ReloadCurrentUser {
  final AuthRepository repository;

  ReloadCurrentUser(this.repository);

  Future<void> call() {
    return repository.reloadUser();
  }
}
