import 'package:flutter/material.dart';

class StartMoreWidget extends StatelessWidget {
  const StartMoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: Text(
            'Mis Compras',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: Text(
            'Historial',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          subtitle: Text(
            'Todo lo que has visto',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
