import 'package:to_do_list_clean_architecture/features/authentication/domain/entities/user.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';

class SignUPUseCase {
  final AuthRepository repository;

  SignUPUseCase({required this.repository});

  Future<void> call(ToDoUser user) async {
    return repository.signUp(user);
  }
}
