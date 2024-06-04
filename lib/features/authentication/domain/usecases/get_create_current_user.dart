import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';

import '../entities/user.dart';

class GetCreateCurrentUserUseCase {
  final AuthRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(ToDoUser user) async {
    return repository.getCreateCurrentUser(user);
  }
}
