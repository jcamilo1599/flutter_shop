import 'package:json_annotation/json_annotation.dart';

part 'cart_resp_api.g.dart';

@JsonSerializable()
class CartRespApiModel {
  CartRespApiModel({
    required this.state,
    this.message,
  });

  final bool state;
  final String? message;

  factory CartRespApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartRespApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartRespApiModelToJson(this);
}
