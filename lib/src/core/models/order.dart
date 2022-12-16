// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:ConsumerApp/src/core/models/product.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.id,
    this.totalAmount,
    this.deliveryCharge,
    this.bankReference,
    this.promoCode,
    this.deliveryTypeId,
    this.shippingAddressId,
    this.billingAddressId,
    this.paymentMethodId,
    this.products,
  });

  String id;
  double totalAmount;
  double deliveryCharge;
  String bankReference;
  String promoCode;
  String deliveryTypeId;
  String shippingAddressId;
  String billingAddressId;
  String paymentMethodId;
  List<Product> products;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
        deliveryCharge:
            json["deliveryCharge"] == null ? null : json["deliveryCharge"],
        bankReference:
            json["bankReference"] == null ? null : json["bankReference"],
        promoCode: json["promoCode"] == null ? null : json["promoCode"],
        deliveryTypeId:
            json["deliveryTypeId"] == null ? null : json["deliveryTypeId"],
        shippingAddressId: json["shippingAddressId"] == null
            ? null
            : json["shippingAddressId"],
        billingAddressId:
            json["billingAddressId"] == null ? null : json["billingAddressId"],
        paymentMethodId:
            json["paymentMethodId"] == null ? null : json["paymentMethodId"],
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    final map = {
      "id": id == null ? null : id,
      "totalAmount": totalAmount == null ? null : totalAmount,
      "deliveryCharge": deliveryCharge == null ? null : deliveryCharge,
      "bankReference": bankReference == null ? null : bankReference,
      "promoCode": promoCode == null ? null : promoCode,
      "deliveryTypeId": deliveryTypeId == null ? null : deliveryTypeId,
      "shippingAddressId": shippingAddressId == null ? null : shippingAddressId,
      "billingAddressId": billingAddressId == null ? null : billingAddressId,
      "paymentMethodId": paymentMethodId == null ? null : paymentMethodId,
      "products": products == null
          ? null
          : List<dynamic>.from(products.map((x) => x.orderOnlyToJson())),
    };
    map.removeWhere((key, value) => key == null || value == null);
    return map;
  }
}
