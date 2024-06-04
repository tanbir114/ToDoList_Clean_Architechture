import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';
import '../../../../shared/errors/failure.dart';
import '../../../../shared/utils/usecase.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;
  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}
