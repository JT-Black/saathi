// @dart=2.9

import 'package:dio/dio.dart';

class HttpUnsplash {
  Dio _dio;

  final baseUrl = "https://api.unsplash.com/";

  HttpUnsplash() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Authorization': "Client-ID y05bAXZAzoDcAciLmoX3nZA4Uzp69Uv4WjylfET3Dxk",
        },
      ),
    );

    // initializeInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;

    try {
      response = await _dio.get(
        endPoint,
        queryParameters: <String, dynamic>{
          'per_page': 18,
          'page': 1,
        },
      );
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    // print(response);
    return response;
  }

  // initializeInterceptors() {
  //   _dio.interceptors.add(InterceptorsWrapper(onError: (error) {
  //     print(error.message);
  //   }, onRequest: (request) {
  //     print("${request.method} ${request.path}");
  //   }, onResponse: (response) {
  //     // print(response);
  //   }));
  // }
}
