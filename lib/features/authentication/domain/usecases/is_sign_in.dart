import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';

class IsSignInUseCase {
  final AuthRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isSignIn();
  }
}
