// To parse this JSON data, do
//
//     final newUser = newUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NewUser newUserFromJson(String str) => NewUser.fromJson(json.decode(str));

String newUserToJson(NewUser data) => json.encode(data.toJson());

class NewUser {
  NewUser({
    @required this.firstName,
    @required this.lastName,
    @required this.phone,
    @required this.email,
    @required this.password,
  });

  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;

  factory NewUser.fromJson(Map<String, dynamic> json) => NewUser(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "password": password,
      };
}
