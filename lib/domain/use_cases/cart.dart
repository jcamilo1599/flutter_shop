import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../config/session_notifier.dart';
import '../../ui/common/atoms/loading.dart';
import '../../ui/common/tokens/color.dart';
import '../../ui/pages/cart/cart.dart';
import '../extensions/string.dart';
import '../models/cart/cart_resp_api.dart';
import '../models/cart/gateway/cart_api_gateway.dart';
import '../models/product/product.dart';
import '../models/users/user.dart';

class CartUseCase {
  final CartApiGateway _gateway;

  CartUseCase(this._gateway);

  void toCart(BuildContext context) =>
      Navigator.pushNamed(context, CartPage.routeName);

  void add(
    BuildContext context,
    WidgetRef ref, {
    required ProductModel product,
  }) {
    final List<ProductModel> shoppingCart = decode(ref)..add(product);
    ref.read(sessionNotifier).shoppingCart = json.encode(shoppingCart);

    showTopSnackBar(
      Overlay.of(context),
      dismissType: DismissType.onSwipe,
      const CustomSnackBar.success(
        backgroundColor: ColorToken.green,
        message: 'Producto agregado al carrito correctamente.',
      ),
    );
  }

  void remove(
    BuildContext context,
    WidgetRef ref, {
    required int productIndex,
  }) {
    final List<ProductModel> shoppingCart = decode(ref)..removeAt(productIndex);

    ref.read(sessionNotifier).shoppingCart = json.encode(shoppingCart);

    showTopSnackBar(
      Overlay.of(context),
      dismissType: DismissType.onSwipe,
      const CustomSnackBar.info(
        message: 'Producto eliminado del carrito.',
      ),
    );
  }

  void clean(
    BuildContext context,
    WidgetRef ref, {
    bool showSnackBar = true,
  }) {
    ref.read(sessionNotifier).shoppingCart = '[]';

    if (showSnackBar) {
      showTopSnackBar(
        Overlay.of(context),
        dismissType: DismissType.onSwipe,
        const CustomSnackBar.info(
          message: 'El carrito se ha vaciado.',
        ),
      );
    }
  }

  Future<void> buy(BuildContext context, WidgetRef ref) async {
    final SessionNotifier session = ref.watch(sessionNotifier);

    if (session.user == '') {
      showTopSnackBar(
        Overlay.of(context),
        dismissType: DismissType.onSwipe,
        const CustomSnackBar.info(
          message:
              'Primero debes iniciar sesión (inicio > icono de la parte superior izquierda)',
        ),
      );

      return;
    }

    await _processBuy(context, ref, session: session);
  }

  Future<void> _processBuy(
    BuildContext context,
    WidgetRef ref, {
    required SessionNotifier session,
  }) async {
    _showLoading(context);

    final Map<String, int> products = _sumGroupProducts(ref);
    final UserModel user = UserModel.fromJson(json.decode(session.user));
    final CartRespApiModel buyProducts = await _gateway.buy(
      userId: user.id,
      data: products,
    );

    _hideLoading(context);

    if (buyProducts.state) {
      // Limpia el carrito
      clean(context, ref, showSnackBar: false);

      showTopSnackBar(
        Overlay.of(context),
        dismissType: DismissType.onSwipe,
        const CustomSnackBar.success(
          backgroundColor: ColorToken.green,
          message: 'Compra realizada correctamente.',
        ),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        dismissType: DismissType.onSwipe,
        CustomSnackBar.error(
          backgroundColor: ColorToken.red,
          message: buyProducts.message!,
        ),
      );
    }
  }

  String getTotal(WidgetRef ref) {
    final List<ProductModel> productsList = decode(ref);
    final int totalSum = productsList.fold(0, (int sum, ProductModel product) {
      return sum + product.price;
    });

    return totalSum.toString().thousand;
  }

  Map<String, List<int>> groupProducts(WidgetRef ref) {
    final List<ProductModel> productsList = decode(ref);
    final Map<String, List<int>> group = <String, List<int>>{};

    /**
     * Necesitaba agrupar los productos, pero no era practico guardar toda la
     * información completa del producto como lo hace "groupBy" de
     * "package:collection/collection.dart", por lo que basandome en esta
     * agrupo solo la posición en la lista que se guarda localmente.
     */
    productsList.asMap().forEach((int index, ProductModel product) {
      if (product.id != null) {
        (group[product.id!] ??= <int>[]).add(index);
      }
    });

    return group;
  }

  List<ProductModel> decode(WidgetRef ref) {
    final SessionNotifier session = ref.watch(sessionNotifier);
    final List<ProductModel> shoppingCart =
        ProductModel.decodeList(session.shoppingCart);

    return shoppingCart;
  }

  Map<String, int> _sumGroupProducts(WidgetRef ref) {
    final Map<String, List<int>> group = groupProducts(ref);
    final Map<String, int> sumGroup = <String, int>{};

    group.forEach((String productId, List<int> productsIndex) {
      sumGroup[productId] = productsIndex.length;
    });

    return sumGroup;
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
