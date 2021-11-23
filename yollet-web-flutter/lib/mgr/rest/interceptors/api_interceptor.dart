import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';

class ApiInterceptor extends Interceptor {
  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    handler.next(options);

    // do something before request is sent
  }

  @override
  Future<dynamic> onError(
    DioError dioError,
    ErrorInterceptorHandler handler,
  ) async {
    log('Api Request Error');
    log(dioError.response.toString());
    log('Api Request Error');
    if (dioError.response != null) {
      appStore.dispatch(UpdateApiAction(
          errorMessage: dioError.response!.data['common']['resMessage']));
    } else {
      appStore
          .dispatch(UpdateApiAction(errorMessage: dioError.error.toString()));
    }

    handler.next(dioError);
    // do something to error
  }

  @override
  Future<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    appStore.dispatch(UpdateApiAction(errorMessage: null));
    handler.next(response);
    // do something before response
  }
}
