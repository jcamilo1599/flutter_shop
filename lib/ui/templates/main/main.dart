import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/use_case_config.dart';
import '../../common/organisms/icon_shopping_cart.dart';
import '../../common/tokens/color.dart';
import '../../common/tokens/size.dart';
import '../../delegates/search.dart';
import '../../pages/start/widgets/account/account.dart';

class TMPLMain extends ConsumerStatefulWidget {
  final String title;
  final Widget child;
  final BottomNavigationBar? bottomNavigationBar;
  final EdgeInsets? margin;
  final bool showActions;

  const TMPLMain({
    required this.title,
    required this.child,
    required this.bottomNavigationBar,
    this.margin = const EdgeInsets.fromLTRB(
      SizeToken.horizontal,
      SizeToken.vertical,
      SizeToken.horizontal,
      SizeToken.vertical,
    ),
    this.showActions = true,
    Key? key,
  }) : super(key: key);

  @override
  _TMPLMainState createState() => _TMPLMainState();
}

class _TMPLMainState extends ConsumerState<TMPLMain> {
  final UseCaseConfig _config = UseCaseConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
        leading: _buildLeading(),
        actions: widget.showActions ? _buildActions(context) : null,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: widget.margin,
          child: widget.child,
        ),
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }

  Widget _buildLeading() {
    return IconButton(
      onPressed: () => _config.account.openDialog(
        context,
        child: const AccountWidget(),
      ),
      icon: const Icon(
        Icons.account_circle,
        color: ColorToken.primary,
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () => _showSearch(context),
        icon: const Icon(Icons.search, color: ColorToken.gray),
      ),
      const IconShoppingCartWidget(),
    ];
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(),
    );
  }
}
