import '../../../domain/models/product/product.dart';
import '../../../domain/models/product/product_resp_api.dart';
import '../../../domain/models/users/gateway/users_api_gateway.dart';
import '../../../domain/models/users/users_purchases_resp_api.dart';
import '../../helpers/api_errors.dart';

class UsersApi extends UsersApiGateway {
  @override
  Future<ProductRespApiModel> getProducts({required String userId}) async {
    ProductRespApiModel response;

    try {
      response = ProductRespApiModel(
        page: 0,
        length: 0,
        products: <ProductModel>[],
        message: '',
      );
    } on Exception catch (error) {
      response = ProductRespApiModel(
        page: 0,
        length: 0,
        products: <ProductModel>[],
        message: apiError(error, '4'),
      );
    }

    return response;
  }

  @override
  Future<UsersPurchasesRespApi> getPurchases({required String userId}) async {
    UsersPurchasesRespApi response;

    try {
      response = UsersPurchasesRespApi(
        length: 0,
        purchases: null,
        message: '',
      );
    } on Exception catch (error) {
      response = UsersPurchasesRespApi(
        length: 0,
        purchases: null,
        message: apiError(error, '5'),
      );
    }

    return response;
  }
}
