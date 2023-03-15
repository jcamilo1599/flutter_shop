import 'package:json_annotation/json_annotation.dart';

part 'product_add_resp_api.g.dart';

@JsonSerializable()
class ProductAddRespApiModel {
  ProductAddRespApiModel({
    required this.state,
    required this.message,
  });

  final bool state;
  final String message;

  factory ProductAddRespApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductAddRespApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductAddRespApiModelToJson(this);
}
