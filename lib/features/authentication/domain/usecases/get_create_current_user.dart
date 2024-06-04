import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';
import '../../../../shared/errors/failure.dart';
import '../../../../shared/utils/usecase.dart';
import '../entities/user.dart';

class GetCreateCurrentUserUseCase implements UseCase<void, Params<ToDoUser>> {
  final AuthRepository repository;
  GetCreateCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Params todouser) async {
    return await repository.getCreateCurrentUser(todouser.data);
  }
}
