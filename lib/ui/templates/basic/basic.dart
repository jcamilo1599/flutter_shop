import 'package:flutter/material.dart';

import '../../common/tokens/color.dart';
import '../../common/tokens/size.dart';

class TMPLBasic extends StatelessWidget {
  final String title;
  final Widget child;
  final bool centerTitle;
  final EdgeInsets margin;
  final List<Widget>? actions;

  const TMPLBasic({
    required this.title,
    required this.child,
    this.centerTitle = true,
    this.margin = const EdgeInsets.fromLTRB(
      SizeToken.horizontal,
      SizeToken.vertical,
      SizeToken.horizontal,
      SizeToken.vertical,
    ),
    this.actions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: centerTitle,
        leading: _buildLeading(context),
        actions: actions,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: margin,
          child: child,
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_ios,
        color: ColorToken.gray.withOpacity(.7),
      ),
    );
  }
}
