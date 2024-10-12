import 'package:book_app/utils/form_validator.dart';

class Validator {
  static final required = MultiValidator([
    RequiredValidator(errorText: 'This field is required'),
  ]).call;
  
   static final password = MultiValidator([
    RequiredValidator(errorText: 'This field is required'),
    MinLegthValidator(6, errorText: 'Password must be at least 6 digits long')
  ]).call;
}
