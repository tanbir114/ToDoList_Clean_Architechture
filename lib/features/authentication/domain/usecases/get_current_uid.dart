import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';

class GetCurrentUidUseCase {
  final AuthRepository repository;

  GetCurrentUidUseCase({required this.repository});

  Future<String> call() async {
    return repository.getCurrentUId();
  }
}
