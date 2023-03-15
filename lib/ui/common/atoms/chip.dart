import 'package:flutter/material.dart';

import '../tokens/color.dart';
import '../tokens/size.dart';

class ChipWidget extends StatelessWidget {
  final Widget child;
  final Color color;

  const ChipWidget({
    required this.child,
    this.color = ColorToken.primary,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: SizeToken.maxWidth),
      decoration: BoxDecoration(
        color: color.withOpacity(.2),
        borderRadius: BorderRadius.circular(SizeToken.radius),
      ),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: child,
    );
  }
}
