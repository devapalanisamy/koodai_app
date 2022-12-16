// To parse this JSON data, do
//
//     final deliveryType = deliveryTypeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DeliveryType> deliveryTypesFromJson(String str) => List<DeliveryType>.from(
    json.decode(str).map((x) => DeliveryType.fromJson(x)));

String deliveryTypesToJson(List<DeliveryType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliveryType {
  DeliveryType({
    @required this.id,
    @required this.description,
    @required this.uniqueId,
    @required this.name,
  });

  final String id;
  final String description;
  final int uniqueId;
  final String name;

  factory DeliveryType.fromJson(Map<String, dynamic> json) => DeliveryType(
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
