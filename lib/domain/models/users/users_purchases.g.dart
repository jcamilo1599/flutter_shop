// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_purchases.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersPurchases _$UsersPurchasesFromJson(Map<String, dynamic> json) =>
    UsersPurchases(
      products:
          (json['products'] as List<dynamic>).map((e) => e as String).toList(),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$UsersPurchasesToJson(UsersPurchases instance) =>
    <String, dynamic>{
      'products': instance.products,
      'userId': instance.userId,
    };
