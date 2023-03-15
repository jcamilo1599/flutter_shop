import 'package:flutter/material.dart';

import '../tokens/color.dart';
import '../tokens/size.dart';

class CardWidget extends StatelessWidget {
  final Widget child;

  const CardWidget({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: SizeToken.maxWidth),
      decoration: BoxDecoration(
        color: ColorToken.grayTransparent,
        borderRadius: BorderRadius.circular(SizeToken.radius),
      ),
      padding: const EdgeInsets.all(SizeToken.spacingMedium),
      child: child,
    );
  }
}
