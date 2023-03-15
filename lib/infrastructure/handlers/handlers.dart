import 'package:flutter/material.dart';

import '../../ui/pages/cart/cart.dart';
import '../../ui/pages/not_found/not_found.dart';
import '../../ui/pages/product/product.dart';
import '../../ui/pages/start/start.dart';

class Handlers {
  /// Obtiene las rutas, y valida si retornara las rutas para usuarios con
  /// sesión activa o inactiva
  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return <String, WidgetBuilder>{
      StartPage.routeName: (BuildContext context) => const StartPage(),
      ProductPage.routeName: (BuildContext context) => const ProductPage(),
      CartPage.routeName: (BuildContext context) => const CartPage(),
    };
  }

  /// Página no encontrada
  static Route<Widget> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute<NotFoundPage>(
      builder: (BuildContext context) => NotFoundPage(),
    );
  }

  /// Ruta inicial del proyecto
  static String getInitialRoute() => '/';
}
