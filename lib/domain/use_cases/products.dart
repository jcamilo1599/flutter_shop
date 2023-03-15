import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../ui/common/atoms/loading.dart';
import '../../ui/common/tokens/color.dart';
import '../../ui/pages/product/product.dart';
import '../mock/products.dart';
import '../models/product/gateway/products_api_gateway.dart';
import '../models/product/product.dart';
import '../models/product/product_add_resp_api.dart';
import '../models/product/product_resp_api.dart';

class ProductsUseCase {
  final ProductsApiGateway _gateway;

  ProductsUseCase(this._gateway);

  Future<ProductRespApiModel> getRecommended() async =>
      _gateway.getRecommended();

  Future<ProductRespApiModel> getFiltered({required String filter}) async =>
      _gateway.getFiltered(filter: filter);

  Future<ProductAddRespApiModel> add(
    BuildContext context, {
    required String userId,
  }) async {
    final ProductModel product = GetProducts.iPhone9(userId);

    _showLoading(context);

    final ProductAddRespApiModel addProduct = await _gateway.add(
      product: product,
    );

    _hideLoading(context);

    showTopSnackBar(
      Overlay.of(context),
      dismissType: DismissType.onSwipe,
      const CustomSnackBar.success(
        backgroundColor: ColorToken.green,
        message: 'Anuncio creado correctamente.',
      ),
    );

    return addProduct;
  }

  void toProduct(
    BuildContext context, {
    required ProductModel product,
  }) {
    Navigator.pushNamed(
      context,
      ProductPage.routeName,
      arguments: product,
    );
  }

  void _showLoading(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const LoadingWidget(),
    );
  }

  void _hideLoading(BuildContext context) => Navigator.pop(context);
}
