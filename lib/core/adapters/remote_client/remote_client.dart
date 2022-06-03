import 'package:academy_modular/core/adapters/remote_client/remote_client_error.dart';
import 'package:academy_modular/core/generics/api_response.dart';
import 'package:dio/dio.dart';

abstract class RemoteClient {
  Future<ApiResponse<Map<String, dynamic>, RemoteClientError>> post(
      String url, Map<String, dynamic> body);
  Future<ApiResponse<Map<String, dynamic>, RemoteClientError>> get(String url);
}

class DioRemoteClient implements RemoteClient {
  final _dio = Dio();

  @override
  Future<ApiResponse<Map<String, dynamic>, RemoteClientError>> get(
      String url) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(url);
      if (response.statusCode != 201) {
        return ApiResponse(
            statusCode: response.statusCode!,
            error: RemoteClientError.badRequest);
      }
      return ApiResponse(statusCode: 201, data: response.data);
    } on DioError catch (_) {
      return ApiResponse(statusCode: 500, error: RemoteClientError.badRequest);
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>, RemoteClientError>> post(
      String url, Map<String, dynamic> body) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(url, data: body);
      if (response.statusCode != 201) {
        return ApiResponse(
            statusCode: response.statusCode!,
            error: RemoteClientError.badRequest);
      }
      return ApiResponse(statusCode: 201, data: response.data);
    } on DioError catch (_) {
      return ApiResponse(statusCode: 500, error: RemoteClientError.badRequest);
    }
  }
}
