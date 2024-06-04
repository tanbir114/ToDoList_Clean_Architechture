import 'package:to_do_list_clean_architecture/features/authentication/data/database/user_remote_database.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/entities/user.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatabase remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> getCurrentUId() async => remoteDataSource.getCurrentUId();

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signIn(ToDoUser user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(ToDoUser user) async => remoteDataSource.signUp(user);

  @override
  Future<void> getCreateCurrentUser(ToDoUser user) async =>
      remoteDataSource.getCreateCurrentUser(user);
}
