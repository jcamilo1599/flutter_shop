import '../../../domain/mock/products.dart';
import '../../../domain/models/product/gateway/products_api_gateway.dart';
import '../../../domain/models/product/product.dart';
import '../../../domain/models/product/product_add_resp_api.dart';
import '../../../domain/models/product/product_resp_api.dart';
import '../../helpers/api_errors.dart';

class ProductsApi extends ProductsApiGateway {
  @override
  Future<ProductRespApiModel> getRecommended() async {
    ProductRespApiModel response;

    try {
      response = ProductRespApiModel(
        page: 0,
        length: 0,
        products: GetProducts.getAll(),
        message: '',
      );
    } on Exception catch (error) {
      response = ProductRespApiModel(
        page: 0,
        length: 0,
        products: <ProductModel>[],
        message: apiError(error, '1'),
      );
    }

    return response;
  }

  @override
  Future<ProductRespApiModel> getFiltered({required String filter}) async {
    ProductRespApiModel response;

    try {
      response = ProductRespApiModel(
        page: 0,
        length: 0,
        products: GetProducts.getAll(), // not filtered
        message: '',
      );
    } on Exception catch (error) {
      response = ProductRespApiModel(
        page: 0,
        length: 0,
        products: <ProductModel>[],
        message: apiError(error, '2'),
      );
    }

    return response;
  }

  @override
  Future<ProductAddRespApiModel> add({required ProductModel product}) async {
    ProductAddRespApiModel response;

    try {
      response = ProductAddRespApiModel(
        state: true,
        message: '',
      );
    } on Exception catch (error) {
      response = ProductAddRespApiModel(
        state: false,
        message: apiError(error, '6'),
      );
    }

    return response;
  }
}
