import 'package:flutter/material.dart';

import '../../../config/use_case_config.dart';
import '../../common/tokens/size.dart';
import '../../templates/basic/basic.dart';

class NotFoundPage extends StatelessWidget {
  NotFoundPage({Key? key}) : super(key: key);

  final UseCaseConfig _config = UseCaseConfig();

  @override
  Widget build(BuildContext context) {
    return TMPLBasic(
      title: 'Página no encontrada',
      child: Column(children: _buildBody(context)),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
    return <Widget>[
      SizedBox(
        width: double.infinity,
        child: Text(
          'Lo sentimos, el lugar al que estás intentando acceder no se encuentrá disponible.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: SizeToken.spacing),
      ElevatedButton(
        onPressed: () => _config.notFound.initialRoute(context),
        child: const Text('Ir al inicio'),
      ),
    ];
  }
}
