// @dart=2.9

import 'package:dio/dio.dart';

class HttpServiceApi {
  Dio _dio;

  final baseUrl = "https://saatchi-data.web.app/";
  // final baseUrl = "http://localhost:5005/";

  HttpServiceApi() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

    // initializeInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;

    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  Future<Response> postRequest(String endPoint, data) async {
    Response response;

    try {
      // print(jsonEncode(data));
      response = await _dio.post(endPoint, data: data);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  // initializeInterceptors() {
  //   _dio.interceptors.add(InterceptorsWrapper(onError: (error) {
  //     print(error.message);
  //   }, onRequest: (request) {
  //     // print("request: ${request.method} ${request.path} ${request.data} ");
  //   }, onResponse: (response) {
  //     // print(response);
  //   }));
  // }
}
