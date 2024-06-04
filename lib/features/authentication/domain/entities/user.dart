import 'dart:convert';

class ToDoUser{
  final String name;
  final String email;
  final String uid;
  final String password;

  ToDoUser({required this.name, required this.email, required this.uid, required this.password});
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'uid': uid,
      'password': password,
    };
  }

  factory ToDoUser.fromMap(Map<String, dynamic> map) {
    return ToDoUser(
      name: map['name'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      password: map['password'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDoUser.fromJson(String source) => ToDoUser.fromMap(json.decode(source) as Map<String, dynamic>);

}
