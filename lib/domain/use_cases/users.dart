import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/session_notifier.dart';
import '../../infrastructure/driven_adapter/users/users_api.dart';
import '../../infrastructure/handlers/handlers.dart';
import '../models/product/product_resp_api.dart';
import '../models/users/user.dart';
import '../models/users/user_login.dart';
import '../models/users/users_purchases_resp_api.dart';

class UsersUseCase {
  final UsersApi _gateway;

  UsersUseCase(this._gateway);

  Future<ProductRespApiModel> getProducts({required String userId}) async =>
      _gateway.getProducts(userId: userId);

  Future<UsersPurchasesRespApi> getPurchases({required String userId}) async =>
      _gateway.getPurchases(userId: userId);

  Future<void> login(
    WidgetRef ref, {
    required UserLoginModel data,
  }) async {
    final UserModel user = UserModel(
      id: 'bfHe0HUQv7YzSMajbRtieoHipXs1',
      displayName: 'Test User',
      email: data.email,
    );

    ref.read(sessionNotifier)
      ..token = '123456'
      ..user = json.encode(user);
  }

  void closeSession(BuildContext context, WidgetRef ref) {
    ref.read(sessionNotifier)
      ..token = ''
      ..user = '';

    // Navega hacia la página inicial para sacar al usuario en caso de estar en
    // otra página
    Navigator.pushNamedAndRemoveUntil(
      context,
      Handlers.getInitialRoute(),
      (Route<dynamic> route) => false,
    );
  }
}
