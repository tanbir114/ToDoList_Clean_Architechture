import 'package:to_do_list_clean_architecture/features/authentication/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthRemoteDatabase {
  Future<bool> isSignIn();
  Future<ToDoUser> signIn(ToDoUser user);
  Future<void> signUp(ToDoUser user);
  Future<void> signOut();
  Future<String> getCurrentUId();
  Future<void> getCreateCurrentUser(ToDoUser user);
}

class AuthRemoteDatabaseImpl implements AuthRemoteDatabase {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDatabaseImpl({required this.auth, required this.firestore});

  @override
  Future<void> getCreateCurrentUser(ToDoUser user) async {
    final userCollectionRef = firestore.collection("users");
    final uid = await getCurrentUId();
    final userDoc = await userCollectionRef.doc(uid).get();

    if (!userDoc.exists) {
      await userCollectionRef.doc(uid).set({
        'uid': uid,
        'email': user.email,
        'name': user.name,
      });
    }
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser != null;

  @override
  Future<ToDoUser> signIn(ToDoUser user) async {
    try {
      print("aaaaaaaaaaaaaaaaaaaaaa");
      print(user.email);
      print(user.password);
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      print("aaaaaaaaaaaaaaaaaaaaaa");
      User? firebaseUser = userCredential.user;
      print(firebaseUser);
      print(userCredential);

      if (firebaseUser != null) {
        return ToDoUser(
          uid: firebaseUser.uid,
          email: firebaseUser.email!,
          name: firebaseUser.displayName ?? 'Unknown', 
          password: user.password,
        );
      } else {
        throw Exception('Failed to sign in user');
      }
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(ToDoUser user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
}

