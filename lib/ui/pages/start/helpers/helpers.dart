import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../config/session_notifier.dart';
import '../../../../domain/models/users/user.dart';
import '../../../common/tokens/size.dart';

class StartHelpers {
  static EdgeInsets? getMargin(int currentIndex) {
    if (currentIndex == 0) {
      return const EdgeInsets.only(bottom: SizeToken.vertical);
    } else if (currentIndex == 2) {
      return const EdgeInsets.fromLTRB(
        0,
        SizeToken.spacing,
        0,
        SizeToken.vertical,
      );
    }

    return null;
  }

  static String getTitle({
    required SessionNotifier session,
    required int currentIndex,
  }) {
    String response = 'Shop';

    if (currentIndex == 2 && session.user != '') {
      final UserModel user = UserModel.fromJson(json.decode(session.user));
      response = 'Hola, ${user.displayName}';
    }

    if (currentIndex == 1) {
      response = 'Mis Anuncios';
    }

    return response;
  }
}
