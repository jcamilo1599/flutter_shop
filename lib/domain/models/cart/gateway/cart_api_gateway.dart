import '../cart_resp_api.dart';

abstract class CartApiGateway {
  Future<CartRespApiModel> buy({
    required String userId,
    required Map<String, int> data,
  });
}
