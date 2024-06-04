import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';
import '../../../../shared/errors/failure.dart';
import '../../../../shared/utils/usecase.dart';

class IsSignInUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;
  IsSignInUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isSignIn();
  }
}
