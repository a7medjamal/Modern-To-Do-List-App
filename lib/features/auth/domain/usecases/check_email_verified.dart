import 'package:cat_to_do_list/features/auth/domain/repositories/auth_repo.dart';

class CheckEmailVerified {
  final AuthRepository repository;

  CheckEmailVerified(this.repository);

  Future<bool> call() {
    return repository.isEmailVerified();
  }
}
