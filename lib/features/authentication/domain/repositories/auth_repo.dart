import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/entities/user.dart';

import '../../../../shared/errors/failure.dart';

abstract class AuthRepository{
  Future<Either<Failure, bool>> isSignIn();
  Future<Either<Failure, ToDoUser>> signIn(ToDoUser user);
  Future<Either<Failure, void>> signUp(ToDoUser user);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, String>> getCurrentUId();
  Future<Either<Failure, void>> getCreateCurrentUser(ToDoUser user);
}
