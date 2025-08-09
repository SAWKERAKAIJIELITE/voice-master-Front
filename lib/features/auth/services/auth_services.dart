import 'package:dio/dio.dart' hide Headers;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/core_models/base_response.dart';
import '../model/auth_model.dart';

part 'auth_services.g.dart';

@RestApi()
@LazySingleton()
abstract class AuthServices {
  @factoryMethod
  factory AuthServices(Dio dio) = _AuthServices;

  @POST("/login/")
  @MultiPart()
  Future<AuthModel> login({
    @Part(name: 'email') required String email,
    @Part(name: 'password') required String password,
  });

  @POST("/register/")
  @MultiPart()
  Future<AuthModel> register({
    @Part(name: 'name') required String firstName,
    @Part(name: 'password') required String password,
    @Part(name: 'email') required String email,
  });
}
