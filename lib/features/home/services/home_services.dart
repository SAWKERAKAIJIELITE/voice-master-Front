import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:voice/features/home/models/exercise.dart';

part 'home_services.g.dart';

@RestApi()
@LazySingleton()
abstract class HomeServices {
  @factoryMethod
  factory HomeServices(Dio dio) = _HomeServices;

  @POST("/upload/")
  @MultiPart()
  Future<ExerciseModel> upload({
    @Part(name: 'audio') required File audio,
    @Part(name: 'text') required String text,
  });

  @GET("/exercises/")
  Future<List<Exercise>> exercises();
}
