import 'package:formz/formz.dart' show FormzInput;

/// Validation errors for the [Password] [FormzInput].
enum PasswordValidationError {
  /// Generic invalid error.
  invalid
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(
    final String? value,
  ) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (value.length < 8 ||
        value.length > 64 ||
        !RegExp('[a-z]').hasMatch(value) ||
        !RegExp('[A-Z]').hasMatch(value) ||
        !RegExp('[0-9]').hasMatch(value) ||
        !RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return PasswordValidationError.invalid;
    }
    return null;
  }
}
