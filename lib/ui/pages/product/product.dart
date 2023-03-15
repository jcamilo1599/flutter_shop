import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/use_case_config.dart';
import '../../../domain/extensions/string.dart';
import '../../../domain/models/product/product.dart';
import '../../common/atoms/image_network.dart';
import '../../common/atoms/loading.dart';
import '../../common/organisms/icon_shopping_cart.dart';
import '../../common/tokens/color.dart';
import '../../common/tokens/size.dart';
import '../../templates/basic/basic.dart';

class ProductPage extends ConsumerStatefulWidget {
  static String routeName = '/product';

  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  final StateProvider<bool> _loading = StateProvider<bool>((_) => true);
  final UseCaseConfig _config = UseCaseConfig();
  late final ProductModel _product;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapperProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool loading = ref.watch(_loading);

    return TMPLBasic(
      centerTitle: false,
      title: loading ? 'Cargando...' : _product.title,
      actions: const <Widget>[IconShoppingCartWidget()],
      margin: const EdgeInsets.fromLTRB(0, 0, 0, SizeToken.vertical),
      child: loading ? const LoadingWidget() : _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildImages(),
        const SizedBox(height: SizeToken.spacing),
        _buildDetailProduct(),
      ],
    );
  }

  Widget _buildImages() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400,
        enlargeCenterPage: true,
        viewportFraction: 1,
      ),
      items: _product.images.map((String? image) {
        if (image == null) {
          return const SizedBox.shrink();
        }

        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: ImageNetworkWidget(path: image),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildDetailProduct() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeToken.horizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ..._buildPurchaseInfo(),
          const Divider(height: 80),
          ..._buildProductInfo(),
        ],
      ),
    );
  }

  List<Widget> _buildPurchaseInfo() {
    return <Widget>[
      Text(
        '\$${_product.price.toString().thousand}',
        style: Theme.of(context).textTheme.displaySmall,
      ),
      const SizedBox(height: SizeToken.spacing),
      ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        leading: const Icon(
          Icons.credit_card,
          color: ColorToken.gray,
        ),
        title: Text(
          'Llevalo hasta 36 cuotas',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          'Con tu VISA terminada en 0000',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ColorToken.gray),
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        leading: const Icon(
          Icons.local_shipping,
          color: ColorToken.green,
        ),
        title: Text(
          'Llega gratis en 2 días',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: ColorToken.green),
        ),
        subtitle: Text(
          'No pagas el domicilio',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ColorToken.gray),
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        leading: const Icon(
          Icons.undo,
          color: ColorToken.green,
        ),
        title: Text(
          'Devolución gratis',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: ColorToken.green),
        ),
        subtitle: Text(
          'Si no estás satisfecho',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ColorToken.gray),
        ),
      ),
      const SizedBox(height: SizeToken.spacing),
      Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () => _config.cart.add(context, ref, product: _product),
            child: const Text('Agregar al carrito'),
          ),
          const SizedBox(height: SizeToken.spacingSmall),
          Container(
            width: double.infinity,
            child: Text(
              _product.stock > 30
                  ? '${_product.stock} disponibles'
                  : 'Solo quedan ${_product.stock} disponibles',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: ColorToken.gray),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildProductInfo() {
    return <Widget>[
      Text(
        'Info. del producto',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: SizeToken.spacingMedium),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          'Marca',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          _product.brand,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: ColorToken.gray),
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          'Categoría',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          _product.category,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: ColorToken.gray),
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          'Descripción',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          _product.description,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: ColorToken.gray),
        ),
      ),
    ];
  }

  void _mapperProduct() {
    final Object? args = ModalRoute.of(context)!.settings.arguments;

    if (args != null) {
      args as ProductModel;
      _product = args;
      ref.read(_loading.notifier).state = false;
    }
  }
}
