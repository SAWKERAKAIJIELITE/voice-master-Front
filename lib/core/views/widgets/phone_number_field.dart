import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../theme/color_light_scheme.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';

class EmailField extends StatelessWidget {
  final String? hint;
  final bool isRequired;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final double borderRadius;

  const EmailField(
      {super.key,
      required this.controller,
      this.hint,
      this.suffixIcon,
      this.isRequired = true,  this.borderRadius=24});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: Validators.validateEmail,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        counterText: '',
        suffixIcon: suffixIcon,
        hintText: hint ?? 'email'.tr(),
      ),
    );
  }
}
