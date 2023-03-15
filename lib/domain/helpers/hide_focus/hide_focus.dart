import 'package:flutter/material.dart';

void hideFocus(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());
