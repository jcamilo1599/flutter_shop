import 'package:flutter/material.dart';

import '../tokens/size.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        margin: const EdgeInsets.all(SizeToken.spacingBig),
        width: SizeToken.spacingBig,
        height: SizeToken.spacingBig,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
