import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../shared/errors/failure.dart';
import '../../../../shared/utils/usecase.dart';

class GetCurrentUidUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;
  GetCurrentUidUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.getCurrentUId();
  }
}
