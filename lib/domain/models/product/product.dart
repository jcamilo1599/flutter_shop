import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductModel {
  ProductModel({
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    required this.userId,
    this.id,
  });

  final String? id;
  final String title;
  final String description;
  final int price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String?> images;
  final String userId;

  static List<ProductModel> decodeList(String products) {
    final List<dynamic> productsList = json.decode(products) as List<dynamic>;

    return productsList.map<ProductModel>((dynamic item) {
      return ProductModel.fromJson(item as Map<String, dynamic>);
    }).toList();
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
