import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'session_preferences.dart';

class SessionNotifier extends ChangeNotifier {
  final SessionPreferences _prefs = SessionPreferences();

  late String _token;
  late String _user;
  late String _shoppingCart;

  SessionNotifier() {
    /// Inicializa los datos del provider
    _initData();

    /// Valida si hay un sesión
    _hasSession();
  }

  String get token => _token;

  String get user => _user;

  String get shoppingCart => _shoppingCart;

  set token(String value) {
    _prefs.token = value;
    _token = value;
    notifyListeners();
  }

  set user(String value) {
    _prefs.user = value;
    _user = value;
    notifyListeners();
  }

  set shoppingCart(String value) {
    _prefs.shoppingCart = value;
    _shoppingCart = value;
    notifyListeners();
  }

  /// Inicializa los datos
  void _initData() {
    _token = '';
    _user = '';
    _shoppingCart = '[]';
  }

  /// Mapea y actualiza el estado con la información guardada localmente
  void _hasSession() {
    _token = _prefs.token;
    _user = _prefs.user;
    _shoppingCart = _prefs.shoppingCart;

    notifyListeners();
  }

  /// Cierra la sesión
  void closeSession() {
    /// Elimina los datos de las preferencias
    _prefs.cleanPreferences();

    /// Inicializa los datos del provider
    _initData();

    notifyListeners();
  }
}

/// Notificador de la sesión
final ChangeNotifierProvider<SessionNotifier> sessionNotifier =
    ChangeNotifierProvider<SessionNotifier>((_) => SessionNotifier());
