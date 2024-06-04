import 'package:to_do_list_clean_architecture/features/authentication/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthRemoteDatabase {
  Future<bool> isSignIn();
  Future<void> signIn(ToDoUser user);
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
    userCollectionRef.doc(uid).get().then((value) {
      final newUser = UserModel(
        uid: uid,
        name: user.name,
        email: user.email,
      ).toDocument();
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(ToDoUser user) async => auth.signInWithEmailAndPassword(
      email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(ToDoUser user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
}

class UserModel extends ToDoUser {
  UserModel({
    final String? name,
    final String? email,
    final String? uid,
    final String? status,
    final String? password,
  }) : super(
            uid: uid,
            name: name,
            email: email,
            password: password,
            status: status);

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      status: documentSnapshot.get('status'),
      name: documentSnapshot.get('name'),
      uid: documentSnapshot.get('uid'),
      email: documentSnapshot.get('email'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {"status": status, "uid": uid, "email": email, "name": name};
  }
}
