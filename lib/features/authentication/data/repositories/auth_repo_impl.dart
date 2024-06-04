import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/authentication/data/database/user_remote_database.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/entities/user.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';
import 'package:to_do_list_clean_architecture/shared/errors/failure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatabase remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> getCreateCurrentUser(ToDoUser user) async {
    try {
      await remoteDataSource.getCreateCurrentUser(user);
      return const Right(null);
    } catch (e) {
      return Left(Failure("we could not get current user"));
    }
  }

  @override
  Future<Either<Failure, String>> getCurrentUId() async {
    try {
      final result = await remoteDataSource.getCurrentUId();
      return Right(result);
    } catch (e) {
      return Left(Failure("we could not get current user"));
    }
  }

  @override
  Future<Either<Failure, bool>> isSignIn() async {
    try {
      final result = await remoteDataSource.isSignIn();
      print(result);
      return Right(result);
    } catch (e) {
      return Left(Failure("you are not signed in"));
    }
  }

  @override
  Future<Either<Failure, ToDoUser>> signIn(ToDoUser user) async {
    try {
      print("rrrrrrrrrrrrrrrrrrrrrrr");
      print(user.email);
      print("rrrrrrrrrrrrrrrrrrrrrrr");
      print(user.password);
      final result = await remoteDataSource.signIn(user);
      print(result);
      return Right(result);
    } catch (e) {
      return Left(Failure("signing in failed"));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Failure("signing out failed"));
    }
  }

  @override
  Future<Either<Failure, void>> signUp(ToDoUser user) async {
    try {
      await remoteDataSource.signUp(user);
      return const Right(null);
    } catch (e) {
      return Left(Failure("sign up failed"));
    }
  }
}
