// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.categoryId,
    this.id,
    this.title,
    this.description,
    this.sellingPrice,
    this.offerPrice,
    this.quantity,
    this.soldQuantity,
    this.imageUrl,
    this.thumbnailImageUrl,
    this.originalImageUrl,
  });

  String categoryId;
  String id;
  String title;
  String description;
  double sellingPrice;
  double offerPrice;
  int quantity;
  int soldQuantity;
  String imageUrl;
  String thumbnailImageUrl;
  String originalImageUrl;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Product && runtimeType == other.runtimeType && id == other.id;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        categoryId: json["categoryId"] == null ? null : json["categoryId"],
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        sellingPrice: json["sellingPrice"] == null
            ? null
            : json["sellingPrice"].toDouble(),
        offerPrice:
            json["offerPrice"] == null ? null : json["offerPrice"].toDouble(),
        quantity: json["quantity"] == null ? null : json["quantity"],
        soldQuantity:
            json["soldQuantity"] == null ? null : json["soldQuantity"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        thumbnailImageUrl: json["thumbnailImageUrl"] == null
            ? null
            : json["thumbnailImageUrl"],
        originalImageUrl:
            json["originalImageUrl"] == null ? null : json["originalImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId == null ? null : categoryId,
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "sellingPrice": sellingPrice == null ? null : sellingPrice,
        "offerPrice": offerPrice == null ? null : offerPrice,
        "quantity": soldQuantity == null ? null : soldQuantity,
        "soldQuantity": soldQuantity == null ? null : soldQuantity,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "thumbnailImageUrl":
            thumbnailImageUrl == null ? null : thumbnailImageUrl,
        "originalImageUrl": originalImageUrl == null ? null : originalImageUrl,
      };

  Map<String, dynamic> orderOnlyToJson() => {
        "productId": id == null ? null : id,
        "quantity": soldQuantity == null ? null : soldQuantity,
      };
}
