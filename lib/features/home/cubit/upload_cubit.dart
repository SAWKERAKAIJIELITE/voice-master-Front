import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:voice/features/home/models/exercise.dart';
import 'package:voice/features/home/repository/home_repository.dart';
import '../../../../core/utils/general.dart';
import '../../../../core/app_cubit/base_state.dart';

@lazySingleton
class UploadCubit extends Cubit<BaseState<ExerciseModel>> {
  final HomeRepository _homeRepository;

  UploadCubit(this._homeRepository) : super(const BaseState.initial());

  Future<void> upload({
    required File audio,
    required String text,
  }) async {
    emit(const BaseState.loading());
    final result = await _homeRepository.upload(
      audio: audio,
      text: text,
    );

    result.fold((l) {
      showToast(message: l.statusMessage);
      emit(BaseState.error(l));
    }, (result) {
      emit(BaseState.loaded(result));
    });
  }
  backToInit(){
    emit(const BaseState.initial());
  }
}