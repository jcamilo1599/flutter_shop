import '../../product/product_resp_api.dart';
import '../users_purchases_resp_api.dart';

abstract class UsersApiGateway {
  Future<ProductRespApiModel> getProducts({required String userId});

  Future<UsersPurchasesRespApi> getPurchases({required String userId});
}
