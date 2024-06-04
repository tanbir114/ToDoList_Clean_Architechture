import 'package:to_do_list_clean_architecture/features/authentication/domain/entities/user.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(ToDoUser user) async {
    return repository.signIn(user);
  }
}
