import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:voice/features/home/services/home_services.dart';
import '../../../core/core_models/error_handler.dart';
import '../../../core/core_models/failure.dart';
import '../models/exercise.dart';

@Singleton()
class HomeRepository {
  final HomeServices _homeServices;

  HomeRepository(
    this._homeServices,
  );

  Future<Either<Failure, ExerciseModel>> upload({
    required File audio,
    required String text,
  }) async {
    try {
      final response = await _homeServices.upload(
        audio: audio,
        text: text,
      );

      return Right(response);
    } on DioException catch (error) {
      return Left(ErrorHandler.handleDioError(error));
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  Future<Either<Failure, List<Exercise>>> exercises() async {
    try {
      final response = await _homeServices.exercises();

      return Right(response);
    } on DioException catch (error) {
      return Left(ErrorHandler.handleDioError(error));
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}
