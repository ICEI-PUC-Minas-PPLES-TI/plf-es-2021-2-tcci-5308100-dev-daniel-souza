import 'package:flutter/material.dart';
import 'package:sglh/stores/login_store.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.icon,
      required this.hint,
      required this.obscure,
      required this.loginStore})
      : super(key: key);

  final IconData icon;
  final String hint;
  final bool obscure;
  final LoginStore loginStore;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
