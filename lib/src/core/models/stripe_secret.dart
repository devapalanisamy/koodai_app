// To parse this JSON data, do
//
//     final stripeSecret = stripeSecretFromJson(jsonString);

import 'dart:convert';

StripeSecret stripeSecretFromJson(String str) =>
    StripeSecret.fromJson(json.decode(str));

String stripeSecretToJson(StripeSecret data) => json.encode(data.toJson());

class StripeSecret {
  StripeSecret({
    this.status,
    this.id,
    this.clientSecret,
  });

  final String status;
  final String id;
  final String clientSecret;

  factory StripeSecret.fromJson(Map<String, dynamic> json) => StripeSecret(
        status: json["status"] == null ? null : json["status"],
        id: json["id"] == null ? null : json["id"],
        clientSecret:
            json["clientSecret"] == null ? null : json["clientSecret"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "id": id == null ? null : id,
        "clientSecret": clientSecret == null ? null : clientSecret,
      };
}
