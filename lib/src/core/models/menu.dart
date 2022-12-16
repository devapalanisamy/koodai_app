// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

import 'package:ConsumerApp/src/core/models/product.dart';

List<Menu> menuFromJson(String str) =>
    List<Menu>.from(json.decode(str).map((x) => Menu.fromJson(x)));

String menuToJson(List<Menu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Menu {
  Menu({
    this.id,
    this.isCategory,
    this.name,
    this.link,
    this.products,
    this.subMenus,
  });

  final String id;
  final bool isCategory;
  final String name;
  final String link;
  final List<Product> products;
  final List<Menu> subMenus;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"] == null ? null : json["id"],
        isCategory: json["isCategory"] == null ? null : json["isCategory"],
        name: json["name"] == null ? null : json["name"],
        link: json["link"] == null ? null : json["link"],
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
        subMenus: json["subMenus"] == null
            ? null
            : List<Menu>.from(json["subMenus"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "isCategory": isCategory == null ? null : isCategory,
        "name": name == null ? null : name,
        "link": link == null ? null : link,
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
        "subMenus": subMenus == null
            ? null
            : List<dynamic>.from(subMenus.map((x) => x.toJson())),
      };
}
