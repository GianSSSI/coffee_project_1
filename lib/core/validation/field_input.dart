import 'package:formz/formz.dart';

enum FieldInputError { empty, invalid }

class FieldInput extends FormzInput<String, FieldInputError> {
  const FieldInput.pure() : super.pure('');
  const FieldInput.dirty([super.value = '']) : super.dirty();

  static final _labelRegExp = RegExp(r'^[a-zA-Z\s]+$');
  @override
  FieldInputError? validator(value) {
    if (value.isEmpty) return FieldInputError.empty;
    if (!_labelRegExp.hasMatch(value)) return FieldInputError.invalid;
    return null;
  }

  String? get errorMessage {
    if (isPure) return null;

    switch (displayError) {
      case FieldInputError.empty:
        return 'Name cannot be empty';
      case FieldInputError.invalid:
        return 'Only letters are allowed';
      default:
        return null;
    }
  }
}
