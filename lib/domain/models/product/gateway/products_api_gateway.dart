import '../product.dart';
import '../product_add_resp_api.dart';
import '../product_resp_api.dart';

abstract class ProductsApiGateway {
  Future<ProductRespApiModel> getRecommended();

  Future<ProductRespApiModel> getFiltered({required String filter});

  Future<ProductAddRespApiModel> add({required ProductModel product});
}
