import 'package:coffee/features/coffee/model/exceptions/api_exception.dart';
import 'package:coffee/core/configuration/app_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  final Dio dio;

  DioClient({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    );

    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ),
      _errorInterceptor(),
    ]);
  }

  InterceptorsWrapper _errorInterceptor() {
    return InterceptorsWrapper(
      onError: (DioException e, handler) {
        debugPrint("Error: ${e.message}");

        String errorMessage = "Something went wrong";
        int? statusCode = e.response?.statusCode;

        if (statusCode == 401) {
          errorMessage = "Unauthorized - maybe token expired";
        } else if (statusCode == 404) {
          errorMessage = "Resource not found";
        } else if (statusCode == 500) {
          errorMessage = "Server error occurred";
        } else if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = "Connection timeout";
        }
        handler.reject(
          DioException(
            requestOptions: e.requestOptions,
            error: ApiException(errorMessage, statusCode: statusCode),
          ),
        );
      },
    );
  }
}
