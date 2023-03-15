// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_resp_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRespApiModel _$ProductRespApiModelFromJson(Map<String, dynamic> json) =>
    ProductRespApiModel(
      page: json['page'] as int,
      length: json['length'] as int,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ProductRespApiModelToJson(
        ProductRespApiModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'length': instance.length,
      'products': instance.products,
      'message': instance.message,
    };
