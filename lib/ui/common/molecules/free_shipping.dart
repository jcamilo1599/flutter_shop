import 'package:flutter/material.dart';

import '../atoms/card.dart';
import '../tokens/color.dart';
import '../tokens/size.dart';

class FreeShippingWidget extends StatelessWidget {
  const FreeShippingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.local_shipping,
            color: ColorToken.primary,
          ),
          const SizedBox(width: SizeToken.spacingSmall),
          Flexible(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: const <TextSpan>[
                  TextSpan(
                    text: 'Envío gratis',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorToken.primary,
                    ),
                  ),
                  TextSpan(text: ' '),
                  TextSpan(text: 'en cientos de productos'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
