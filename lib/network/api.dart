import "package:dio/dio.dart";
import 'package:marvel_api/network/api_path.dart';
import 'package:marvel_api/network/interceptor/interceptor.dart';

class API {
  static API? _instance;
  static API get instance {
    _instance ??= API._init();
    return _instance!;
  }

  API._init();

  Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiPath.baseUrl,
        contentType: "application/json",
        connectTimeout: 10000,
      ),
    );
    dio.interceptors.add(AppInterceptor(dio));
    return dio;
  }
}
