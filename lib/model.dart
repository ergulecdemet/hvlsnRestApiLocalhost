// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.user,
  });

  List<UserElement>? user;

  factory User.fromJson(Map<String, dynamic> json) => User(
      user: (json["user"] != null
          ? List<UserElement>.from(
              json["user"].map((x) => UserElement.fromJson(x)))
          : null));

  Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user!.map((x) => x.toJson())),
      };
}

class UserElement {
  UserElement({
    required this.name,
    required this.surname,
    required this.lessonsId,
    required this.id,
  });

  String name;
  String surname;
  String lessonsId;
  int id;

  factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
        name: json["name"],
        surname: json["surname"],
        lessonsId: json["lessonsId"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "lessonsId": lessonsId,
        "id": id,
      };
}
