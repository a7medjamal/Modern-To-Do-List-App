import 'package:cat_to_do_list/features/auth/domain/repositories/auth_repo.dart';

class SendEmailVerification {
  final AuthRepository authRepository;

  SendEmailVerification(this.authRepository);

  Future<void> call() async {
    return await authRepository.sendEmailVerification();
  }
}
