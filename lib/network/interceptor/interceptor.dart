import "dart:developer";

import "package:dio/dio.dart";

class AppInterceptor extends Interceptor {
  late RequestOptions _options;

  final Dio dio;

  AppInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _options = options;
    log(_options.uri.toString());
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null) {
      handler.resolve(err.response!);
    } else {
      handler.reject(err);
    }
  }
}
