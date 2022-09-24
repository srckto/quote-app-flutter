import 'dart:convert';
import 'dart:io';

import 'package:quote/core/api/app_interceptors.dart';
import 'package:quote/core/api/end_points.dart';
import 'package:quote/core/api/status_code.dart';
import 'package:quote/core/error/exceptions.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'package:quote/core/api/api_consumer.dart';
import 'package:quote/injection_container.dart' as di;
import 'package:flutter/foundation.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;
  DioConsumer({
    required this.client,
  }) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return (status ?? 500) < StatusCode.internalServerError;
      };

    client.interceptors.add(di.sl<AppInterceptors>());
    if (kDebugMode) client.interceptors.add(di.sl<LogInterceptor>());
  }

  @override
  Future get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await client.get(url, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    bool formDataIsEnable = false,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await client.post(
        url,
        data: formDataIsEnable ? FormData.fromMap(body!) : body,
        queryParameters: queryParameters,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await client.put(
        url,
        data: body,
        queryParameters: queryParameters,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data);
    return responseJson;
  }

  _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw FetchDataException();

      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw BadRequestException();
          case StatusCode.conflict:
            throw ConflictException();
          case StatusCode.forbidden:
          case StatusCode.unauthorized:
            throw UnauthorizedException();
          case StatusCode.notFound:
            throw NotFoundException();
          case StatusCode.internalServerError:
            throw InternalServerErrorException();
        }
        break;

      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException();
      default:
        throw UnknownException();
    }
  }
}
