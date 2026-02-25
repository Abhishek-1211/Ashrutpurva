import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../../../../core/constants/api_constants.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<void> register(String email, String password, String? phoneNumber);
  Future<UserModel> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Login failed');
    }
  }

  @override
  Future<void> register(String email, String password, String? phoneNumber) async {
    try {
      await _dio.post(
        ApiConstants.register,
        data: {
          'email': email,
          'password': password,
          'phone_number': phoneNumber,
        },
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['email']?[0] ?? 'Registration failed');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _dio.get(ApiConstants.profile);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to get user');
    }
  }
}
