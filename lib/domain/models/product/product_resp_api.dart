import 'package:json_annotation/json_annotation.dart';

import 'product.dart';

part 'product_resp_api.g.dart';

@JsonSerializable()
class ProductRespApiModel {
  ProductRespApiModel({
    required this.page,
    required this.length,
    required this.products,
    this.message,
  });

  final int page;
  final int length;
  final List<ProductModel> products;
  final String? message;

  factory ProductRespApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductRespApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRespApiModelToJson(this);
}
