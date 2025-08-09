import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/general.dart';
import '../../model/auth_model.dart';
import '../../repository/auth_repository.dart';
import '../../../../core/app_cubit/base_state.dart';

@lazySingleton
class AuthCubit extends Cubit<BaseState<AuthModel>> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const BaseState.initial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const BaseState.loading());
    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    result.fold((l) {
      showToast(message: l.statusMessage);
      emit(BaseState.error(l));
    }, (result) {
      emit(BaseState.loaded(result));
    });
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const BaseState.loading());
    final result = await _authRepository.register(
      email: email,
      password: password,
      name: name,
    );

    result.fold((l) {
      showToast(message: l.statusMessage);
      emit(BaseState.error(l));
    }, (result) {
      emit(BaseState.loaded(result));
    });
  }

  Future<bool> logout({bool callApi = true}) async {
    final result = await _authRepository.logout(callApi);
    emit(const BaseState.initial());
    return result.isRight();
  }

  String? getToken() {
    final token = getIt<SharedPreferences>().getString(Constants.tokenKey);
    return token;
  }

  User? getUser() {
    final userJson = getIt<SharedPreferences>().getString(Constants.userKey);

    return User.fromJson(json.decode(userJson ?? '{}'));
  }

  UserType getUserType() {
    String? type = getUser()?.fluencyLevel?.toLowerCase();
    switch (type) {
      case 'patient':
        return UserType.patient;
      case 'doctor':
        return UserType.doctor;
    }
    return UserType.patient;
  }
}

enum UserType { patient, doctor }
