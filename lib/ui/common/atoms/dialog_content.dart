import 'package:flutter/material.dart';

import '../tokens/size.dart';

class DialogContentWidget extends StatelessWidget {
  final String title;
  final List<Widget> content;
  final List<Widget>? actions;
  final EdgeInsets contentPadding;

  const DialogContentWidget({
    required this.title,
    required this.content,
    this.actions,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: SizeToken.horizontal,
      vertical: SizeToken.spacingSmall,
    ),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SimpleDialog(
        clipBehavior: Clip.antiAlias,
        title: Text(title),
        titlePadding: const EdgeInsets.symmetric(
          horizontal: SizeToken.horizontal,
          vertical: SizeToken.spacing,
        ),
        contentPadding: contentPadding,
        children: <Widget>[
          ...content,
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    if (actions == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const SizedBox(height: SizeToken.spacing),
        Wrap(
          alignment: WrapAlignment.end,
          spacing: SizeToken.spacingSmall,
          children: actions!,
        ),
      ],
    );
  }
}
