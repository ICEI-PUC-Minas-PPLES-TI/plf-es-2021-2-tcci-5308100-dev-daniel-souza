import 'package:flutter/material.dart';
import 'package:clock_in/views/components/utils/styles.dart';

@immutable
class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final String Function(T) getLabel;
  final void Function(T?)? onChanged;

  const AppDropdownInput({
    Key? key,
    this.hintText = 'Selecione uma opção',
    this.options = const [],
    required this.getLabel,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding: getContentPadding(),
            labelText: hintText,
            labelStyle: getTextLabelStyle(),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(
                    getLabel(value),
                    style: getFormTextStyle(),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
