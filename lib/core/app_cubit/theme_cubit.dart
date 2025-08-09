import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'theme_state.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState.initial());

  ThemeMode themeMode = ThemeMode.light;

  setTheme(ThemeMode themeMode) async {
    emit(const ThemeState.initial());
    this.themeMode = themeMode;
    HapticFeedback.mediumImpact();
    emit(ThemeState.loaded(themeMode));
  }
}
