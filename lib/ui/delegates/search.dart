import 'package:flutter/material.dart';

import '../../config/use_case_config.dart';
import '../../domain/models/product/product.dart';
import '../../domain/models/product/product_resp_api.dart';
import '../common/atoms/loading.dart';
import '../common/organisms/product_list.dart';
import '../common/tokens/color.dart';
import '../common/tokens/size.dart';

class CustomSearchDelegate extends SearchDelegate<ProductModel?> {
  final UseCaseConfig _config = UseCaseConfig();
  List<ProductModel> _products = <ProductModel>[];

  CustomSearchDelegate()
      : super(
          searchFieldLabel: 'Buscar....',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(border: InputBorder.none),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear, color: ColorToken.gray),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: ColorToken.gray),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return _buildText(
        context,
        text: 'Ingresa más de dos caracteres para realizar la busqueda',
      );
    }

    if (_products.isEmpty) {
      return _buildText(
        context,
        text: 'No se encontron productos',
      );
    }

    return _buildProductsList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return _buildText(
        context,
        text: 'Ingresa más de dos caracteres para realizar la busqueda',
      );
    }

    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder<ProductRespApiModel>(
      future: _config.products.getFiltered(filter: query),
      builder: (_, AsyncSnapshot<ProductRespApiModel> snapshot) {
        // Determina si hay datos y si la respuesta fue correcta
        final bool hasData = snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done;

        if (hasData) {
          _products = snapshot.data!.products;

          if (_products.isEmpty) {
            return _buildText(
              context,
              text: 'No se encontron productos',
            );
          }

          return _buildProductsList(context);
        } else if (snapshot.hasError) {
          return _buildProductsError(context);
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  Widget _buildProductsList(BuildContext context) {
    return ListView(
      children: List<ProductListWidget>.generate(_products.length, (int index) {
        return ProductListWidget(
          product: _products[index],
          onTap: () => _config.products.toProduct(
            context,
            product: _products[index],
          ),
        );
      }),
    );
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

  Widget _buildText(
    BuildContext context, {
    required String text,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SizeToken.horizontal),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
