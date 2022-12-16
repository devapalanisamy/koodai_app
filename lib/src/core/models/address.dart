// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);
//     final addresses = addressesFromJson(jsonString);

import 'dart:convert';

List<Address> addressesFromJson(String str) =>
    List<Address>.from(json.decode(str).map((x) => Address.fromJson(x)));

String addressesToJson(List<Address> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.id,
    this.fullName,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.mobile,
    this.postCode,
    this.userAccountId,
  });

  String id;
  String fullName;
  String addressLine1;
  String addressLine2;
  String city;
  String mobile;
  String postCode;
  String userAccountId;

  @override
  String toString() =>
      '$fullName, $addressLine1 $addressLine2, $city, $postCode, $mobile';

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        addressLine1:
            json["addressLine1"] == null ? null : json["addressLine1"],
        addressLine2:
            json["addressLine2"] == null ? null : json["addressLine2"],
        city: json["city"] == null ? null : json["city"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        postCode: json["postCode"] == null ? null : json["postCode"],
        userAccountId:
            json["userAccountId"] == null ? null : json["userAccountId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "fullName": fullName == null ? null : fullName,
        "addressLine1": addressLine1 == null ? null : addressLine1,
        "addressLine2": addressLine2 == null ? null : addressLine2,
        "city": city == null ? null : city,
        "mobile": mobile == null ? null : mobile,
        "postCode": postCode == null ? null : postCode,
        "userAccountId": userAccountId == null ? null : userAccountId,
      };
}
