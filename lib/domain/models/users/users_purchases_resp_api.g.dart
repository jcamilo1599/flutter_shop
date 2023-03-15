// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_purchases_resp_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersPurchasesRespApi _$UsersPurchasesRespApiFromJson(
        Map<String, dynamic> json) =>
    UsersPurchasesRespApi(
      length: json['length'] as int,
      purchases: (json['purchases'] as List<dynamic>?)
          ?.map((e) => UsersPurchases.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UsersPurchasesRespApiToJson(
        UsersPurchasesRespApi instance) =>
    <String, dynamic>{
      'length': instance.length,
      'purchases': instance.purchases,
      'message': instance.message,
    };
