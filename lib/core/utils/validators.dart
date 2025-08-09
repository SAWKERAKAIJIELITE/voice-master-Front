import 'package:easy_localization/easy_localization.dart';

class Validators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "email_error".tr();
    }

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return "email_error".tr();
    }

    return null; // Valid email
  }
  static String? validatePassword(String? password) {
    if ((password?.length??0)<6) {
      return "password_error".tr();
    }

    return null; // Valid email
  }
  static String? validateName(String? name) {
    if ((name?.length??0)==0) {
      return "name_error".tr();
    }

    return null; // Valid email
  }
  static String? validateEmpty(String? name) {
    if (name?.isEmpty??true) {
      return "field_error".tr();
    }

    return null; // Valid email
  }

  static String? validatePhone(String? phone) {
    if ((phone?.length??0)<9) {
      return "phone_error".tr();
    }
    if(int.tryParse(phone??'')==null){
      return "phone_error".tr();

    }

    return null; // Valid email
  }
}
