import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../features/auth/cubit/auth_cubit/auth_cubit.dart';
import '../utils/general.dart';
import '../utils/go_router.dart';
import 'injection_container.dart';

class AppInterceptor extends QueuedInterceptor {
  final Dio dio;

  AppInterceptor(this.dio);

  late Map<String, String> headers;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token=getIt<AuthCubit>().getToken();
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if(token!=null)'Authorization': 'Bearer ${token}',
    };

    options.headers.addAll(headers);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
  @override
  void onError(DioException err,ErrorInterceptorHandler handler){
    if(err.response?.statusCode==401){
      goRouter.go(NamedRoutes.signin);
      getIt<AuthCubit>().logout(callApi: false);
    }
    if(err.requestOptions.method=='POST'&&err.response?.statusCode==401){
      showToast(message: 'please_login_to_access_this_feature'.tr());
    }
    handler.next(err);
    super.onError(err, handler);
  }
}
