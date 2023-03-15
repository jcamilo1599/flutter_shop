import 'package:shared_preferences/shared_preferences.dart';

class SessionPreferences {
  static final SessionPreferences _instance = SessionPreferences._internal();

  factory SessionPreferences() => _instance;
  SharedPreferences? _prefs;

  SessionPreferences._internal();

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Token de la sesión
  set token(String value) => _prefs?.setString('token', value);

  String get token => _prefs?.getString('token') ?? '';

  /// Información del usuario
  set user(String value) => _prefs?.setString('user', value);

  String get user => _prefs?.getString('user') ?? '';

  /// Información del usuario
  set shoppingCart(String value) => _prefs?.setString('shoppingCart', value);

  String get shoppingCart => _prefs?.getString('shoppingCart') ?? '[]';

  /// Reinicia datos de las preferencias
  void cleanPreferences() {
    token = '';
    user = '';
  }
}
