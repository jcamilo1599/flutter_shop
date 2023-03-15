import 'package:json_annotation/json_annotation.dart';

import 'users_purchases.dart';

part 'users_purchases_resp_api.g.dart';

@JsonSerializable()
class UsersPurchasesRespApi {
  int length;
  List<UsersPurchases>? purchases;
  String? message;

  UsersPurchasesRespApi({
    required this.length,
    required this.purchases,
    this.message,
  });

  factory UsersPurchasesRespApi.fromJson(Map<String, dynamic> json) =>
      _$UsersPurchasesRespApiFromJson(json);

  Map<String, dynamic> toJson() => _$UsersPurchasesRespApiToJson(this);
}
