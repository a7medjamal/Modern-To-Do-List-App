import 'package:cat_to_do_list/features/auth/domain/repositories/auth_repo.dart';

class SendPasswordResetEmail {
  final AuthRepository authRepository;

  SendPasswordResetEmail(this.authRepository);

  Future<void> call(String email) async {
    return await authRepository.sendPasswordResetEmail(email);
  }
}
