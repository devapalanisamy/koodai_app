// To parse this JSON data, do
//
//     final appSettings = appSettingsFromJson(jsonString);

import 'dart:convert';

AppSettings appSettingsFromJson(String str) =>
    AppSettings.fromJson(json.decode(str));

String appSettingsToJson(AppSettings data) => json.encode(data.toJson());

class AppSettings {
  AppSettings({
    this.name,
    this.minimumOrderForDelivery,
    this.minimumOrderForPickup,
    this.freeDeliveryMinimumAmount,
    this.deliveryCharge,
    this.announcementMessage,
    this.mobileNumber,
    this.address,
    this.whatsAppNumber,
    this.faceBookPageUrl,
    this.instagramAccountUrl,
    this.logoUrl,
    this.noImageUrl,
    this.banners,
  });

  final String name;
  final int minimumOrderForDelivery;
  final int minimumOrderForPickup;
  final int freeDeliveryMinimumAmount;
  final int deliveryCharge;
  final String announcementMessage;
  final dynamic mobileNumber;
  final String address;
  final dynamic whatsAppNumber;
  final dynamic faceBookPageUrl;
  final dynamic instagramAccountUrl;
  final String logoUrl;
  final String noImageUrl;
  final List<String> banners;

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        name: json["name"] == null ? null : json["name"],
        minimumOrderForDelivery: json["minimumOrderForDelivery"] == null
            ? null
            : json["minimumOrderForDelivery"],
        minimumOrderForPickup: json["minimumOrderForPickup"] == null
            ? null
            : json["minimumOrderForPickup"],
        freeDeliveryMinimumAmount: json["freeDeliveryMinimumAmount"] == null
            ? null
            : json["freeDeliveryMinimumAmount"],
        deliveryCharge:
            json["deliveryCharge"] == null ? null : json["deliveryCharge"],
        announcementMessage: json["announcementMessage"] == null
            ? null
            : json["announcementMessage"],
        mobileNumber: json["mobileNumber"],
        address: json["address"] == null ? null : json["address"],
        whatsAppNumber: json["whatsAppNumber"],
        faceBookPageUrl: json["faceBookPageUrl"],
        instagramAccountUrl: json["instagramAccountUrl"],
        logoUrl: json["logoUrl"] == null ? null : json["logoUrl"],
        noImageUrl: json["noImageUrl"] == null ? null : json["noImageUrl"],
        banners: json["banners"] == null
            ? null
            : List<String>.from(json["banners"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "minimumOrderForDelivery":
            minimumOrderForDelivery == null ? null : minimumOrderForDelivery,
        "minimumOrderForPickup":
            minimumOrderForPickup == null ? null : minimumOrderForPickup,
        "freeDeliveryMinimumAmount": freeDeliveryMinimumAmount == null
            ? null
            : freeDeliveryMinimumAmount,
        "deliveryCharge": deliveryCharge == null ? null : deliveryCharge,
        "announcementMessage":
            announcementMessage == null ? null : announcementMessage,
        "mobileNumber": mobileNumber,
        "address": address == null ? null : address,
        "whatsAppNumber": whatsAppNumber,
        "faceBookPageUrl": faceBookPageUrl,
        "instagramAccountUrl": instagramAccountUrl,
        "logoUrl": logoUrl == null ? null : logoUrl,
        "noImageUrl": noImageUrl == null ? null : noImageUrl,
        "banners":
            banners == null ? null : List<String>.from(banners.map((x) => x)),
      };
}
