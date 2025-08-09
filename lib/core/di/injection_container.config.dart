// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:voice/core/app_cubit/theme_cubit.dart' as _i836;
import 'package:voice/core/di/app_module.dart' as _i444;
import 'package:voice/core/utils/notification_manager.dart' as _i384;
import 'package:voice/features/auth/cubit/auth_cubit/auth_cubit.dart' as _i828;
import 'package:voice/features/auth/repository/auth_repository.dart' as _i86;
import 'package:voice/features/auth/services/auth_services.dart' as _i20;
import 'package:voice/features/home/cubit/main_cubit/botttom_nav_cubit.dart'
    as _i362;
import 'package:voice/features/home/cubit/upload_cubit.dart' as _i725;
import 'package:voice/features/home/repository/home_repository.dart' as _i849;
import 'package:voice/features/home/services/home_services.dart' as _i527;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i836.ThemeCubit>(() => _i836.ThemeCubit());
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i384.NotificationManager>(
        () => _i384.NotificationManager());
    gh.lazySingleton<_i362.BottomNavCubit>(() => _i362.BottomNavCubit());
    gh.lazySingleton<_i20.AuthServices>(
        () => _i20.AuthServices(gh<_i361.Dio>()));
    gh.lazySingleton<_i527.HomeServices>(
        () => _i527.HomeServices(gh<_i361.Dio>()));
    gh.singleton<_i849.HomeRepository>(
        () => _i849.HomeRepository(gh<_i527.HomeServices>()));
    gh.singleton<_i86.AuthRepository>(
        () => _i86.AuthRepository(gh<_i20.AuthServices>()));
    gh.lazySingleton<_i725.UploadCubit>(
        () => _i725.UploadCubit(gh<_i849.HomeRepository>()));
    gh.lazySingleton<_i828.AuthCubit>(
        () => _i828.AuthCubit(gh<_i86.AuthRepository>()));
    return this;
  }
}

class _$AppModule extends _i444.AppModule {}
