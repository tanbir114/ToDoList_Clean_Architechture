import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';
import '../../../../shared/errors/failure.dart';
import '../../../../shared/utils/usecase.dart';
import '../entities/user.dart';

class SignUpUseCase implements UseCase<void, Params<ToDoUser>> {
  final AuthRepository repository;
  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Params todouser) async {
    return await repository.signUp(todouser.data);
  }
}
