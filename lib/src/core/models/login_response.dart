// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.userName,
    this.role,
    this.token,
    this.sessionId,
  });

  String id;
  String firstName;
  String lastName;
  dynamic middleName;
  String userName;
  String role;
  String token;
  String sessionId;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["id"] == null ? null : json["id"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        middleName: json["middleName"],
        userName: json["userName"] == null ? null : json["userName"],
        role: json["role"] == null ? null : json["role"],
        token: json["token"] == null ? null : json["token"],
        sessionId: json["sessionId"] == null ? null : json["sessionId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "middleName": middleName,
        "userName": userName == null ? null : userName,
        "role": role == null ? null : role,
        "token": token == null ? null : token,
        "sessionId": sessionId == null ? null : sessionId,
      };
}
