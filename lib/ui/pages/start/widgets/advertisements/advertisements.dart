import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/session_notifier.dart';
import '../../../../../config/use_case_config.dart';
import '../../../../../domain/models/product/product.dart';
import '../../../../../domain/models/product/product_resp_api.dart';
import '../../../../../domain/models/users/user.dart';
import '../../../../common/atoms/loading.dart';
import '../../../../common/organisms/product_list.dart';
import '../../../../common/tokens/size.dart';

class StartAdvertisementsWidget extends ConsumerStatefulWidget {
  const StartAdvertisementsWidget({Key? key}) : super(key: key);

  @override
  _StartAdvertisementsWidgetState createState() =>
      _StartAdvertisementsWidgetState();
}

class _StartAdvertisementsWidgetState
    extends ConsumerState<StartAdvertisementsWidget> {
  final UseCaseConfig _config = UseCaseConfig();
  final StateProvider<bool> _loading = StateProvider<bool>((_) => true);
  final StateProvider<List<ProductModel>> _products =
      StateProvider<List<ProductModel>>((_) => <ProductModel>[]);

  late final SessionNotifier _session = ref.watch(sessionNotifier);
  late final UserModel _user = UserModel.fromJson(json.decode(_session.user));

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildButtonAddProduct(),
        _buildBody(context),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    if (ref.watch(_loading)) {
      return const LoadingWidget();
    }

    return _buildProductsList(
      context,
      products: ref.watch(_products),
    );
  }

  Widget _buildButtonAddProduct() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        SizeToken.horizontal,
        0,
        SizeToken.horizontal,
        SizeToken.spacing,
      ),
      alignment: Alignment.topRight,
      child: ElevatedButton(
        onPressed: _createAdvertisements,
        child: const Text('Crear Anuncio'),
      ),
    );
  }

  Widget _buildProductsList(
    BuildContext context, {
    required List<ProductModel> products,
  }) {
    return SingleChildScrollView(
      child: Column(
        children:
            List<ProductListWidget>.generate(products.length, (int index) {
          return ProductListWidget(
            product: products[index],
            onTap: () {},
          );
        }),
      ),
    );
  }

  Future<void> _createAdvertisements() async {
    await _config.products.add(context, userId: _user.id);
    await _getProducts();
  }

  Future<void> _getProducts() async {
    ref.read(_loading.notifier).state = true;

    final ProductRespApiModel getProducts =
        await _config.users.getProducts(userId: _user.id);

    if (getProducts.products.isNotEmpty) {
      ref.read(_products.notifier).state = getProducts.products;
    }

    ref.read(_loading.notifier).state = false;
  }
}
