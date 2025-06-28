import 'package:dio/dio.dart';

import 'api_response.dart';
import 'error.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  Future<ApiResponse> fetchData(String endpoint) async {
    try {
      final response = await dio.get(endpoint);
      if (response.statusCode != 200) {
        throw ServerException(message: response.data);
      }
      final meta = Meta.fromJson(response.data['meta']);
      if (meta.code != 200) {
        throw ServerException(message: meta.message ?? meta.code.toString());
      }
      return ApiResponse(data: response.data['data']);
    } on DioException catch (e) {
      throw ServerException(
        statusCode: e.response?.statusCode,
        message:
            e.response?.data['meta']['message'] ??
            'Failed to fetch data endpoint: $endpoint',
      );
    }
  }

  Future<ApiResponse> postData(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await dio.post(endpoint, data: data);
      final responseData = response.data as Map<String, dynamic>;
      final metaData = responseData['meta'];
      final meta = Meta.fromJson(metaData);
      if (meta.code != 200) {
        throw ServerException(message: meta.message ?? meta.code.toString());
      }
      return ApiResponse(data: response.data['data'] ?? meta.message);
    } on DioException catch (e) {
      throw ServerException(
        statusCode: e.response?.statusCode,
        message:
            e.response?.data['meta']['message'] ??
            'Failed to post data endpoint $endpoint',
      );
    }
  }

  Future<ApiResponse> patchData(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await dio.patch(endpoint, data: data);
      final meta = Meta.fromJson(response.data['meta']);
      if (meta.code != 200) {
        throw ServerException(message: meta.message ?? meta.code.toString());
      }
      return ApiResponse(data: response.data['data']);
    } on DioException catch (e) {
      throw ServerException(
        statusCode: e.response?.statusCode,
        message:
            e.response?.data['meta']['message'] ??
            'Failed to patch data endpoint $endpoint',
      );
    }
  }

  Future<ApiResponse> deleteData(String endpoint) async {
    try {
      final response = await dio.delete(endpoint);
      final meta = Meta.fromJson(response.data['meta']);
      if (meta.code != 200) {
        throw ServerException(message: meta.message ?? meta.code.toString());
      }
      return ApiResponse(data: response.data['data']);
    } on DioException catch (e) {
      throw ServerException(
        statusCode: e.response?.statusCode,
        message:
            e.response?.data['meta']['message'] ??
            'Failed to delete data endpoint $endpoint',
      );
    }
  }
}
