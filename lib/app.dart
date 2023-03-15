import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/helpers/hide_focus/hide_focus.dart';
import 'infrastructure/handlers/handlers.dart';
import 'ui/common/tokens/themes.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => hideFocus(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop',
        routes: Handlers.getRoutes(context),
        initialRoute: Handlers.getInitialRoute(),
        onUnknownRoute: Handlers.unknownRoute,
        theme: Themes.light,
        darkTheme: Themes.dark,
      ),
    );
  }
}
