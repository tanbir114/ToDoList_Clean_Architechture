import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }
}
