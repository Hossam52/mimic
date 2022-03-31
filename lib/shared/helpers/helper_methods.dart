import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class HelperMethods {
  static void closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please Enter Your Email';
    } else if (!EmailValidator.validate(value)) {
      return 'Please Enter Valid Email';
    }
    return null;
  }
 
}
