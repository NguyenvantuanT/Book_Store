abstract class FieldValidator<T> {
  final String errorText;
  FieldValidator(this.errorText);

  bool isValid(String? value);

  String? call(String value) {
    return isValid(value) ? null : errorText;
  }
}

abstract class TextFormValidator extends FieldValidator<String> {
  TextFormValidator(super.errorText);

  bool get ignoreEmptyValues => true;

  @override
  String? call(String value) {
    return (ignoreEmptyValues && value.isEmpty) ? null : super.call(value);
  }

  bool hasMatch(String pattern, String input, {bool caseSensitive = true}) =>
      RegExp(pattern, caseSensitive: caseSensitive).hasMatch(input);
}

class RequiredValidator extends TextFormValidator {
  RequiredValidator({required String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    return value!.trim().isNotEmpty;
  }

  @override
  String? call(String value) {
    return isValid(value) ? null : super.call(value);
  }
}

class MinLegthValidator extends TextFormValidator {
  final int min;
  MinLegthValidator(this.min, {required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    return value!.length >= min;
  }

  @override
  String? call(String value) {
    return isValid(value) ? null : super.call(value);
  }
}

class MultiValidator extends FieldValidator<String> {
  final List<FieldValidator> validators;
  static String _errorText = '';
  MultiValidator(this.validators) : super(_errorText);

  @override
  bool isValid(String? value) {
    for (FieldValidator validator in validators) {
      if (validator.call(value!) != null) {
        _errorText = validator.errorText;
        return false;
      }
    }
    return true;
  }

  @override
  String? call(dynamic value) {
    return isValid(value) ? null : _errorText;
  }
}
