import '../../../core/api_service.dart';
import '../../../core/error.dart';
import '../../model/user/user.dart';

abstract class UserRemoteDatasource {
  Future<User> login(String email, String password);
  Future<User> register(
    String name,
    String email,
    String mobile,
    String dob,
    String gender,
  );
  Future<String> logout();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final ApiService apiService;

  UserRemoteDatasourceImpl({required this.apiService});

  @override
  Future<User> register(
    String name,
    String email,
    String mobile,
    String dob,
    String gender,
  ) async {
    try {
      final response = await apiService.postData('/auth/register', {
        'name': name,
        'email': email,
        'no_hp': mobile,
        'dob': dob,
        'gender': gender,
      });
      final responseData = response.data as Map<String, dynamic>;
      final accessToken = 'Bearer ${responseData['access_token']}';
      User user = User.fromJson(responseData['user']);
      user = user.copyWith(token: accessToken);
      return user;
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await apiService.postData('/auth/login', {
        'no_hp': email,
        'password': password,
      });
      final responseData = response.data as Map<String, dynamic>;
      final accessToken = 'Bearer ${responseData['access_token']}';
      User user = User.fromJson(responseData['user']);
      user = user.copyWith(token: accessToken);
      return user;
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<String> logout() async {
    try {
      final response = await apiService.postData('/auth/logout', {});
      return response.data;
    } on ServerException {
      rethrow;
    }
  }
}
