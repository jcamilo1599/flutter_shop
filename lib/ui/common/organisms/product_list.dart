import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/extensions/string.dart';
import '../../../domain/models/product/product.dart';
import '../atoms/chip.dart';
import '../atoms/image_network.dart';
import '../tokens/color.dart';
import '../tokens/size.dart';

class ProductListWidget extends ConsumerWidget {
  final ProductModel product;
  final void Function()? onTap;
  final bool isCart;
  final void Function()? onRemove;

  const ProductListWidget({
    required this.product,
    this.onTap,
    this.isCart = false,
    this.onRemove,
    Key? key,
  })  : assert(
          onRemove == null && isCart == false ||
              onRemove != null && isCart == true,
          '"onRemove" solo se acepta o es requerido cuando "isCart" es "true"',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: SizeToken.spacingSmall),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: SizeToken.horizontal),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SizeToken.radius),
                child: SizedBox(
                  width: isCart ? 100 : 130,
                  height: isCart ? 100 : 130,
                  child: ImageNetworkWidget(path: product.thumbnail),
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: SizeToken.spacingSmall),
                        ..._buildChipStock(context),
                        _buildChipFreeShipping(context, price: product.price),
                        const SizedBox(width: SizeToken.spacingSmall),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SizeToken.spacingSmall,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                product.title,
                                style: Theme.of(context).textTheme.bodyLarge,
                                overflow: isCart ? TextOverflow.ellipsis : null,
                              ),
                              Text(
                                '\$${product.price.toString().thousand}',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildRemove(context, ref),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChipStock(BuildContext context) {
    if (isCart) {
      return <Widget>[];
    }

    return <Widget>[
      ChipWidget(
        child: Text(
          'Quedan ${product.stock}',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ColorToken.gray),
        ),
      ),
      const SizedBox(width: SizeToken.spacingSmall),
    ];
  }

  Widget _buildChipFreeShipping(
    BuildContext context, {
    required int price,
  }) {
    if (price < 70) {
      return const SizedBox.shrink();
    }

    return ChipWidget(
      color: ColorToken.green,
      child: Wrap(
        children: <Widget>[
          const Icon(
            Icons.local_shipping,
            color: ColorToken.green,
          ),
          const SizedBox(width: SizeToken.spacingSmall),
          Text(
            'Envío gratis',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: ColorToken.gray),
          ),
        ],
      ),
    );
  }

  Widget _buildRemove(BuildContext context, WidgetRef ref) {
    if (!isCart) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(right: SizeToken.horizontal),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeToken.radius),
        child: SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
            icon: const Icon(
              Icons.delete_outlined,
              color: ColorToken.red,
            ),
            onPressed: onRemove,
          ),
        ),
      ),
    );
  }
}
