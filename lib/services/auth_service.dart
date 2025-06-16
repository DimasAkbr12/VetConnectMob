import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  final _storage = GetStorage();
  
  // Key untuk storage
  static const String _tokenKey = 'auth_token';
  
  // Getter untuk token
  String? get token => _storage.read(_tokenKey);
  
  // Setter untuk token
  void setToken(String token) {
    _storage.write(_tokenKey, token);
  }
  
  // Hapus token
  void removeToken() {
    _storage.remove(_tokenKey);
  }
  
  // Check apakah user sudah login
  bool get isLoggedIn => token != null;
  
  // Headers dengan bearer token
  Map<String, String> get headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    return headers;
  }
}