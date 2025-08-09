import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/di/injection_container.dart';
import '../../../core/core_models/error_handler.dart';
import '../../../core/core_models/failure.dart';
import '../../../core/utils/constants.dart';
import '../model/auth_model.dart';
import '../services/auth_services.dart';

@Singleton()
class AuthRepository {
  final AuthServices _authServices;

  AuthRepository(
    this._authServices,
  );

  Future<Either<Failure, AuthModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authServices.login(
        email: email,
        password: password,
      );

      _saveUser(response);
      return Right(response);
    } on DioException catch (error) {
      return Left(ErrorHandler.handleDioError(error));
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  Future<Either<Failure, AuthModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authServices.register(
        email: email,
        password: password,
        firstName: name,
      );
      _saveUser(response);
      return Right(response);
    } on DioException catch (error) {
      return Left(ErrorHandler.handleDioError(error));
    }
  }

  Future<Either<Failure, bool>> logout(bool callApi) async {
    try {
      // if (callApi) {
      //   final response = await _authServices.logout();
      //   getIt<SharedPreferences>().remove(Constants.tokenKey);
      //   return Right(response );
      // }else{
      getIt<SharedPreferences>().remove(Constants.tokenKey);
      return const Right(true);
      // }
    } on DioException catch (error) {
      return Left(ErrorHandler.handleDioError(error));
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  _saveUser(AuthModel model) async {
    if (model.token?.isNotEmpty ?? false) {
      getIt<SharedPreferences>()
          .setString(Constants.tokenKey, model.token ?? '');
      getIt<SharedPreferences>().setString(
          Constants.userKey, json.encode(model.user?.toJson() ?? {}));
    }
  }
}
