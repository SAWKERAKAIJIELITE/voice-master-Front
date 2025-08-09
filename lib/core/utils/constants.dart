import 'dart:io';

import 'package:flutter/material.dart';

class Constants {
  static const String appName = 'Voice';

  static String baseUrl = 'https://ysrabd.pythonanywhere.com/mdd/api';

  static const kDesignSize = Size(428, 926);

  static String defaultCountryCode = Platform.isIOS?'+971': '+963';

  static const tokenKey = 'token_key';
  static const userKey = 'user_key';

  static const Duration connectTimeout = Duration(seconds: 20);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration sendTimeout = Duration(seconds: 20);
  static const Duration prodConnectTimeout = Duration(seconds: 20);
  static const Duration prodReceiveTimeout = Duration(seconds: 20);
  static const Duration prodSendTimeout = Duration(seconds: 20);
}
