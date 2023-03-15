// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_add_resp_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAddRespApiModel _$ProductAddRespApiModelFromJson(
        Map<String, dynamic> json) =>
    ProductAddRespApiModel(
      state: json['state'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ProductAddRespApiModelToJson(
        ProductAddRespApiModel instance) =>
    <String, dynamic>{
      'state': instance.state,
      'message': instance.message,
    };
