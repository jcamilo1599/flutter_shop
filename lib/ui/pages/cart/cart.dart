import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/use_case_config.dart';
import '../../../domain/models/product/product.dart';
import '../../common/organisms/product_list.dart';
import '../../common/tokens/size.dart';
import '../../templates/basic/basic.dart';

class CartPage extends ConsumerStatefulWidget {
  static String routeName = '/cart';

  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  final UseCaseConfig _config = UseCaseConfig();

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> shoppingCart = _config.cart.decode(ref);

    return TMPLBasic(
      title: 'Mi carrito',
      margin: const EdgeInsets.fromLTRB(
        0,
        SizeToken.spacing,
        0,
        SizeToken.vertical,
      ),
      child: shoppingCart.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildBody(),
              ),
            )
          : _buildBodyCleanCart(),
    );
  }

  List<Widget> _buildBody() {
    final String productsTotal = _config.cart.getTotal(ref);

    return <Widget>[
      Container(
        alignment: Alignment.topRight,
        padding: const EdgeInsets.symmetric(horizontal: SizeToken.horizontal),
        child: ElevatedButton(
          onPressed: () => _config.cart.clean(context, ref),
          child: const Text('Vaciar carrito'),
        ),
      ),
      const SizedBox(height: SizeToken.spacing),
      ..._buildProductsList(),
      const Divider(height: 80),
      Container(
        alignment: Alignment.topRight,
        padding: const EdgeInsets.symmetric(horizontal: SizeToken.horizontal),
        child: ElevatedButton(
          onPressed: () => _config.cart.buy(context, ref),
          child: Text('Comprar - Total \$$productsTotal'),
        ),
      ),
    ];
  }

  List<Widget> _buildProductsList() {
    final List<ProductModel> products = _config.cart.decode(ref);

    return List<ProductListWidget>.generate(products.length, (int index) {
      return ProductListWidget(
        isCart: true,
        product: products[index],
        onRemove: () => _config.cart.remove(
          context,
          ref,
          productIndex: index,
        ),
      );
    });
  }

  Widget _buildBodyCleanCart() {
    return Center(
      child: Text(
        'Tu carrito esta vacio.',
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
