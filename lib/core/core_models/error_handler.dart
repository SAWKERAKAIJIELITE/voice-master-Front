import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  static Failure handle(dynamic error, {String? errorMessage}) {
    return Failure(
        statusCode: 403,
        statusMessage: errorMessage ?? 'msg_not_internet'.tr());
  }

  static Failure handleDioError(DioException error) {
    String? message;
    try {
      message = json.decode(error.response.toString()).toString();
    } catch (e) {}
    return Failure(
        statusCode: error.response?.statusCode ?? 400,
        statusMessage: message ?? 'msg_not_internet'.tr());
  }
}
