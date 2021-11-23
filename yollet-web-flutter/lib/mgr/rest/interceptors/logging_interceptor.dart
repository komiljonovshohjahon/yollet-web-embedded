import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:developer' as developer;

/// [LoggingInterceptor] is used to print logs during network requests.
/// It's better to add [LoggingInterceptor] to the tail of the interceptor queue,
/// otherwise the changes made in the interceptor behind A will not be printed out.
/// This is because the execution of interceptors is in the order of addition.
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor();

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    logPrint('*** API Request - Start ***');
    printKV('URI', options.uri);
    printKV('METHOD', options.method);
    logPrint('HEADERS:');
    if (options.contentType != "multipart/form-data") {
      options.headers.forEach((key, v) => printKV(' - $key', v));
      logPrint('BODY:');
      print(options.data ?? '');
    }

    logPrint('*** API Request - End ***\n');
    handler.next(options);
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    logPrint('*** API Error - Start ***:');

    logPrint('URI: ${err.requestOptions.uri}');
    if (err.response != null) {
      logPrint('STATUS CODE: ${err.response!.statusCode.toString()}\n');
    }
    logPrint('$err');
    if (err.response != null) {
      printKV('REDIRECT', err.requestOptions.uri);
      logPrint('BODY:');
      print(err.response?.toString());
    }

    logPrint('*** API Error - End ***:\n');
    handler.next(err);

    return err;
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    logPrint('*** API Response - Start ***');
    printKV('PATH', response.requestOptions.uri.path);
    printKV('STATUS CODE', response.statusCode.toString());
    printKV('REDIRECT', response.isRedirect.toString());
    logPrint('HEADERS:');
    response.headers.forEach((key, v) => printKV(' - $key', v));
    if (response.data != null) {
      logPrint('BODY:');
      print(response.data.toString());
      logPrint('*** API Response - End ***\n');
    }
    handler.next(response);

    return response;
  }

  void printKV(key, Object v) {
    logPrint('$key: $v');
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  void logPrint(s) {
    developer.log(s);
  }
}
