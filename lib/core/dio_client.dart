import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final String baseUrl;
  final SharedPreferences sharedPreferences;

  Dio get dio => _getDio();

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      contentType: 'application/json',
      headers: {'Accept': 'application/json'},
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 10),
    );

    Dio dio = Dio(options);

    dio.interceptors.addAll(<Interceptor>[_loggingInterceptor()]);

    return dio;
  }

  DioClient({required this.baseUrl, required this.sharedPreferences});

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // print(
        //     'Check LOGOUT ${!options.uri.path.contains('auth') || options.uri.pathSegments.contains('logout')}');
        // print('TOKEN ${sharedPreferences.getString('token')}');
        // Do something before request is sent
        if (!options.uri.path.contains('auth') ||
            options.uri.pathSegments.contains('logout')) {
          options.headers['Authorization'] =
              sharedPreferences.getString('token') ?? '';
        }
        print(
          '\n'
          'Request ${options.method} ${options.uri} \n'
          '-- headers --\n'
          '${options.headers.toString()} \n'
          '-- body --\n'
          '${options.data} \n'
          '-- queryParam -- \n'
          '${options.queryParameters}',
        );
        return handler.next(options); //continue
        // If you want to resolve the request with some custom data，
        // you can return a `Response` object or return `dio.resolve(data)`.
        // If you want to reject the request with a error message,
        // you can return a `DioError` object or return `dio.reject(errMsg)`
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // Do something with response data
        if (response.statusCode == 200) {
          print(
            '\n'
            'Response ${response.requestOptions.uri} \n'
            '-- headers --\n'
            '${response.headers.toString()} \n'
            '-- payload --\n'
            '${jsonEncode(response.data)} \n'
            '',
          );
        } else {
          print('Dio Response Status --> ${response.statusCode}');
        }
        return handler.next(response); // continue
      },
      onError: (DioException e, ErrorInterceptorHandler handler) {
        // Do something with response error
        print('Dio Response Error --> $e');
        print('Response --> ${e.response?.data}');
        return handler.next(e); //continue
      },
    );
  }
}
