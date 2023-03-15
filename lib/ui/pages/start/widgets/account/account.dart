import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/session_notifier.dart';
import '../../../../../config/use_case_config.dart';
import '../../../../../domain/models/users/user.dart';
import '../../../../../domain/models/users/user_login.dart';
import '../../../../common/atoms/dialog_content.dart';
import '../../../../common/tokens/size.dart';

class AccountWidget extends ConsumerStatefulWidget {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends ConsumerState<AccountWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UseCaseConfig _config = UseCaseConfig();

  late final TextEditingController _ctrlEmail = TextEditingController();
  late final TextEditingController _ctrlPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SessionNotifier session = ref.watch(sessionNotifier);

    return Container(
      constraints: const BoxConstraints(maxWidth: SizeToken.maxWidth),
      child: DialogContentWidget(
        title: session.token == '' ? 'Iniciar sesión' : 'Mi cuenta',
        content: session.token == '' ? _buildLogin() : _buildMyAccount(session),
      ),
    );
  }

  List<Widget> _buildMyAccount(SessionNotifier session) {
    final UserModel user = UserModel.fromJson(json.decode(session.user));

    return <Widget>[
      TextField(
        controller: TextEditingController(text: user.displayName),
        enabled: false,
        readOnly: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: const Icon(Icons.person),
          labelText: 'Mi nombre',
        ),
      ),
      const SizedBox(height: SizeToken.spacingMedium),
      TextField(
        controller: TextEditingController(text: user.email),
        enabled: false,
        readOnly: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: const Icon(Icons.alternate_email),
          labelText: 'Correo electrónico',
        ),
      ),
      const SizedBox(height: SizeToken.spacing),
      Wrap(
        alignment: WrapAlignment.end,
        spacing: SizeToken.spacingSmall,
        children: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () => _config.users.closeSession(context, ref),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildLogin() {
    return <Widget>[
      Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            _buildEmail(),
            const SizedBox(height: SizeToken.spacingMedium),
            _buildPassword(),
          ],
        ),
      ),
      const SizedBox(height: SizeToken.spacing),
      Wrap(
        alignment: WrapAlignment.end,
        spacing: SizeToken.spacingSmall,
        children: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: _login,
            child: const Text('Iniciar sesión'),
          ),
        ],
      ),
    ];
  }

  Widget _buildEmail() {
    return TextFormField(
      controller: _ctrlEmail,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: const Icon(Icons.alternate_email),
        labelText: 'Correo electrónico',
      ),
      validator: (String? value) => (value != null && value == '')
          ? 'Ingresa tu correo electrónico'
          : (!EmailValidator.validate(value!))
              ? 'Ingresa un correo electrónico valido'
              : null,
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      controller: _ctrlPass,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: const Icon(Icons.lock),
        labelText: 'Contraseña',
      ),
      validator: (String? value) =>
          (value != null && value == '') ? 'Ingresa la contraseña' : null,
    );
  }

  Future<void> _login() async {
    _formKey.currentState!.validate();

    if (_ctrlEmail.text == '' || _ctrlPass.text == '') {
      return;
    }

    final UserLoginModel userLogin = UserLoginModel(
      email: _ctrlEmail.text,
      password: _ctrlPass.text,
    );

    await _config.users.login(ref, data: userLogin);

    // Cierra el modal de la cuenta
    Navigator.pop(context);
  }
}
