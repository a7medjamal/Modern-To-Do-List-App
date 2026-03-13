import 'package:cat_to_do_list/features/auth/domain/repositories/auth_repo.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<void> call() => repository.signInWithGoogle();
}
