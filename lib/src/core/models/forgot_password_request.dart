// To parse this JSON data, do
//
//     final forgotPasswordRequest = forgotPasswordRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ForgotPasswordRequest forgotPasswordRequestFromJson(String str) =>
    ForgotPasswordRequest.fromJson(json.decode(str));

String forgotPasswordRequestToJson(ForgotPasswordRequest data) =>
    json.encode(data.toJson());

class ForgotPasswordRequest {
  ForgotPasswordRequest({
    @required this.userName,
  });

  final String userName;

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordRequest(
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
      };
}
