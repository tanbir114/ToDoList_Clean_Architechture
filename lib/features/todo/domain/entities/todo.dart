import 'dart:convert';

class Todo {
  final String id;
  final String text;
  final String description;
  final String uid;
  final DateTime dateTime;

  Todo({
    required this.id,
    required this.text,
    required this.description,
    required this.uid,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'description': description,
      'uid': uid,
      'dateTime':
          dateTime.toIso8601String(), // Store dateTime as ISO-8601 string
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      text: map['text'] as String,
      description: map['description'] as String,
      uid: map['uid'] as String,
      dateTime: DateTime.parse(map['dateTime'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
