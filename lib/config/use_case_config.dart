import '../domain/use_cases/account.dart';
import '../domain/use_cases/cart.dart';
import '../domain/use_cases/not_found.dart';
import '../domain/use_cases/products.dart';
import '../domain/use_cases/users.dart';
import '../infrastructure/driven_adapter/cart/cart_api.dart';
import '../infrastructure/driven_adapter/products/products_api.dart';
import '../infrastructure/driven_adapter/users/users_api.dart';
import '../infrastructure/handlers/handlers.dart';

class UseCaseConfig {
  late final NotFoundUseCase notFound;
  late final AccountUseCase account;

  late final ProductsApi _productsApiGateway;
  late final ProductsUseCase products;

  late final CartApi _cartApiGateway;
  late final CartUseCase cart;

  late final UsersApi _usersApiGateway;
  late final UsersUseCase users;

  UseCaseConfig() {
    notFound = NotFoundUseCase(Handlers.getInitialRoute());
    account = AccountUseCase();

    _productsApiGateway = ProductsApi();
    products = ProductsUseCase(_productsApiGateway);

    _cartApiGateway = CartApi();
    cart = CartUseCase(_cartApiGateway);

    _usersApiGateway = UsersApi();
    users = UsersUseCase(_usersApiGateway);
  }
}
