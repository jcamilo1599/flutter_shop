import '../../../domain/models/cart/cart_resp_api.dart';
import '../../../domain/models/cart/gateway/cart_api_gateway.dart';
import '../../helpers/api_errors.dart';

class CartApi extends CartApiGateway {
  @override
  Future<CartRespApiModel> buy({
    required String userId,
    required Map<String, int> data,
  }) async {
    CartRespApiModel response;

    try {
      response = CartRespApiModel(
        state: true,
        message: 'Compra realiza correctamente',
      );
    } on Exception catch (error) {
      response = CartRespApiModel(
        state: false,
        message: apiError(error, '3'),
      );
    }

    return response;
  }
}
