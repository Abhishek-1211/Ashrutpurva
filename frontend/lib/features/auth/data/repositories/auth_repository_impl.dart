import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage storage;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.storage,
  });

  @override
  Future<User> login(String email, String password) async {
    final response = await remoteDataSource.login(email, password);
    final accessToken = response['access'];
    final refreshToken = response['refresh'];
    
    await storage.write(key: 'access_token', value: accessToken);
    await storage.write(key: 'refresh_token', value: refreshToken);
    
    return await remoteDataSource.getCurrentUser();
  }

  @override
  Future<void> register(String email, String password, String? phoneNumber) async {
    await remoteDataSource.register(email, password, phoneNumber);
  }

  @override
  Future<User?> getCurrentUser() async {
    final token = await storage.read(key: 'access_token');
    if (token == null) return null;
    
    try {
      return await remoteDataSource.getCurrentUser();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }
}
