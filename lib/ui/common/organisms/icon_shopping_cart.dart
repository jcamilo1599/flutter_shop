import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/use_case_config.dart';
import '../../../domain/models/product/product.dart';
import '../tokens/color.dart';

class IconShoppingCartWidget extends ConsumerWidget {
  const IconShoppingCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UseCaseConfig config = UseCaseConfig();
    final List<ProductModel> shoppingCart = config.cart.decode(ref);
    final String label =
        shoppingCart.length > 9 ? '9+' : shoppingCart.length.toString();

    return badges.Badge(
      badgeContent: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: ColorToken.white),
      ),
      showBadge: shoppingCart.isNotEmpty,
      position: badges.BadgePosition.topEnd(
        top: 0,
        end: shoppingCart.length > 9 ? 20 : 25,
      ),
      badgeAnimation: const badges.BadgeAnimation.fade(),
      badgeStyle: const badges.BadgeStyle(badgeColor: ColorToken.green),
      child: IconButton(
        onPressed: () => config.cart.toCart(context),
        icon: Icon(
          Icons.shopping_cart,
          color: shoppingCart.isEmpty ? ColorToken.gray : ColorToken.primary,
        ),
      ),
    );
  }
}
