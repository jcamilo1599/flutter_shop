import 'package:flutter/material.dart';

class AccountUseCase {
  AccountUseCase();

  void openDialog(
    BuildContext context, {
    required Widget child,
  }) {
    showDialog<void>(
      context: context,
      builder: (_) => child,
    );
  }
}
