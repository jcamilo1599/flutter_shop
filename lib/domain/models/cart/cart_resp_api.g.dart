// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_resp_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartRespApiModel _$CartRespApiModelFromJson(Map<String, dynamic> json) =>
    CartRespApiModel(
      state: json['state'] as bool,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CartRespApiModelToJson(CartRespApiModel instance) =>
    <String, dynamic>{
      'state': instance.state,
      'message': instance.message,
    };
