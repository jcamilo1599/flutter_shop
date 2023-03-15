import 'package:flutter/material.dart';

import '../../../../../config/use_case_config.dart';
import '../../../../../domain/models/product/product.dart';
import '../../../../../domain/models/product/product_resp_api.dart';
import '../../../../common/atoms/loading.dart';
import '../../../../common/molecules/free_shipping.dart';
import '../../../../common/organisms/product_list.dart';
import '../../../../common/tokens/size.dart';

class StartHomeWidget extends StatelessWidget {
  StartHomeWidget({Key? key}) : super(key: key);

  final UseCaseConfig _config = UseCaseConfig();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeToken.horizontal),
          child: FreeShippingWidget(),
        ),
        _buildBody(context),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder<ProductRespApiModel>(
      future: _config.products.getRecommended(),
      builder: (_, AsyncSnapshot<ProductRespApiModel> snapshot) {
        // Determina si hay datos y si la respuesta fue correcta
        final bool hasData = snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done;

        if (hasData) {
          return _buildProducts(
            context,
            products: snapshot.data!.products,
          );
        } else if (snapshot.hasError) {
          return _buildProductsError(context);
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  Widget _buildProducts(
    BuildContext context, {
    required List<ProductModel> products,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: SizeToken.spacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeToken.horizontal),
          child: Text(
            'Quedan pocos...',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildProductsList(context, products: products),
        ),
        const SizedBox(height: SizeToken.spacingSmall),
        Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.only(right: SizeToken.horizontal),
          child: TextButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Text('Ver más'),
                SizedBox(width: SizeToken.spacingSmall),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<ProductListWidget> _buildProductsList(
    BuildContext context, {
    required List<ProductModel> products,
  }) {
    return List<ProductListWidget>.generate(products.length, (int index) {
      return ProductListWidget(
        product: products[index],
        onTap: () => _config.products.toProduct(
          context,
          product: products[index],
        ),
      );
    });
  }

  Widget _buildProductsError(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeToken.spacing),
      alignment: Alignment.center,
      child: Text(
        'Se produjo un error, no se cargaron los productos',
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
