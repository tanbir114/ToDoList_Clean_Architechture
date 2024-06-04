import 'package:to_do_list_clean_architecture/features/authentication/domain/entities/user.dart';

abstract class AuthRepository{
  Future<bool> isSignIn();
  Future<void> signIn(ToDoUser user);
  Future<void> signUp(ToDoUser user);
  Future<void> signOut();
  Future<String> getCurrentUId();
  Future<void> getCreateCurrentUser(ToDoUser user);
}
