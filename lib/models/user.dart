// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.fullName,
    this.email,
    this.project,
    this.socketId,
  });

  String fullName;
  String email;
  String project;
  String socketId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json["fullName"],
        email: json["email"],
        project: json["project"],
        socketId: json["socketId"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "project": project,
        "socketId": socketId,

      };
}
