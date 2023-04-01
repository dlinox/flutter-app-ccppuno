import 'package:formz/formz.dart';

// Define input validation errors
enum DniError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Dni extends FormzInput<String, DniError> {
  static final RegExp dniRegExp = RegExp(
    r'^[0-9]*$',
  );

  // Call super.pure to represent an unmodified form input.
  const Dni.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Dni.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DniError.empty) return 'El campo es requerido';
    if (displayError == DniError.format) return 'Solo se permite numeros';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DniError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DniError.empty;
    if (!dniRegExp.hasMatch(value)) return DniError.format;

    return null;
  }
}
