import 'package:json_annotation/json_annotation.dart';

part 'users_purchases.g.dart';

@JsonSerializable()
class UsersPurchases {
  List<String> products;
  String userId;

  UsersPurchases({
    required this.products,
    required this.userId,
  });

  factory UsersPurchases.fromJson(Map<String, dynamic> json) =>
      _$UsersPurchasesFromJson(json);

  Map<String, dynamic> toJson() => _$UsersPurchasesToJson(this);
}
