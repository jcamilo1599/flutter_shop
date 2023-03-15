import 'package:flutter/cupertino.dart';

class NotFoundUseCase {
  final String _initialRoute;

  NotFoundUseCase(this._initialRoute);

  void initialRoute(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      _initialRoute,
      (Route<dynamic> route) => false,
    );
  }
}
