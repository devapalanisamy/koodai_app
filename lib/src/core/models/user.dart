// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.roleId,
    this.email,
    this.isActive,
    this.isVerified,
  });

  String id;
  String firstName;
  String lastName;
  String phone;
  String roleId;
  String email;
  bool isActive;
  bool isVerified;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        phone: json["phone"] == null ? null : json["phone"],
        roleId: json["roleId"] == null ? null : json["roleId"],
        email: json["email"] == null ? null : json["email"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        isVerified: json["isVerified"] == null ? null : json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "phone": phone == null ? null : phone,
        "roleId": roleId == null ? null : roleId,
        "email": email == null ? null : email,
        "isActive": isActive == null ? null : isActive,
        "isVerified": isVerified == null ? null : isVerified,
      };
}
