import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/session_notifier.dart';
import '../../common/tokens/color.dart';
import '../../templates/main/main.dart';
import 'helpers/helpers.dart';
import 'widgets/advertisements/advertisements.dart';
import 'widgets/home/home.dart';
import 'widgets/more/more.dart';

class StartPage extends ConsumerStatefulWidget {
  static String routeName = '/';

  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends ConsumerState<StartPage> {
  final StateProvider<int> _selectedIndex = StateProvider<int>((_) => 0);

  @override
  Widget build(BuildContext context) {
    final int currentIndex = ref.watch(_selectedIndex);
    final SessionNotifier session = ref.watch(sessionNotifier);

    return TMPLMain(
      title: StartHelpers.getTitle(
        session: session,
        currentIndex: currentIndex,
      ),
      showActions: currentIndex == 0,
      margin: StartHelpers.getMargin(currentIndex),
      bottomNavigationBar: _buildBottomNavBar(ref, currentIndex: currentIndex),
      child: _buildBody(
        context,
        ref,
        currentIndex: currentIndex,
      ),
    );
  }

  BottomNavigationBar? _buildBottomNavBar(
    WidgetRef ref, {
    required int currentIndex,
  }) {
    final SessionNotifier session = ref.watch(sessionNotifier);

    if (session.token == '') {
      return null;
    }

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'Mis Anuncios',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Más',
        ),
      ],
      currentIndex: session.token != '' ? currentIndex : 0,
      selectedItemColor: ColorToken.primary,
      onTap: (int index) => ref.read(_selectedIndex.notifier).state = index,
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref, {
    required int currentIndex,
  }) {
    Widget response;

    switch (currentIndex) {
      case 2:
        response = const StartMoreWidget();
        break;
      case 1:
        response = const StartAdvertisementsWidget();
        break;
      default:
        response = StartHomeWidget();
        break;
    }

    return response;
  }
}
