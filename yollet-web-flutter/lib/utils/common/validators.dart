import 'package:yollet_web/UI/template/base/template.dart';

class Validator {
  String? validateDomain(value, VoidCallback callback) {
    if (value == null) {
      callback();
      return 'Domain must be selected!';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value != null && value.length < 4) {
      return 'Password must be more than 4 characters!';
    } else {
      return null;
    }
  }

  String? validateId(String? value) {
    if (value != null && value.length < 6) {
      return 'ID must be more than 6 characters!';
    } else {
      return null;
    }
  }
}
