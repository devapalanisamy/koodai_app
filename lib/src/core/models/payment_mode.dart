// To parse this JSON data, do
//
//     final paymentMode = paymentModeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PaymentMode> paymentModesFromJson(String str) => List<PaymentMode>.from(
    json.decode(str).map((x) => PaymentMode.fromJson(x)));

String paymentModesToJson(List<PaymentMode> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentMode {
  PaymentMode({
    @required this.id,
    @required this.description,
    @required this.uniqueId,
    @required this.name,
  });

  final String id;
  final String description;
  final int uniqueId;
  final String name;

  factory PaymentMode.fromJson(Map<String, dynamic> json) => PaymentMode(
        id: json["id"],
        description: json["description"],
        uniqueId: json["uniqueId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "uniqueId": uniqueId,
        "name": name,
      };
}
