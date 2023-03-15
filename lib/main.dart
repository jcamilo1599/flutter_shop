import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'config/session_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SessionPreferences prefs = SessionPreferences();
  await prefs.initPrefs();

  runApp(const ProviderScope(child: App()));
}
