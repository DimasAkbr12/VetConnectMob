import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import 'package:get_storage/get_storage.dart';

class ArticleApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const Duration defaultTimeout = Duration(seconds: 10);

  static String? _getToken() {
    final box = GetStorage();
    return box.read("token");
  }

  // HTTP client instance for better testability and connection reuse
  static final http.Client _client = http.Client();

  /// Fetches all articles from the API
  static Future<List<Article>> fetchArticles({
    int? page,
    int? limit,
    String? category,
  }) async {
    final Map<String, String> queryParams = {};

    if (page != null) queryParams['page'] = page.toString();
    if (limit != null) queryParams['limit'] = limit.toString();
    if (category != null) queryParams['category'] = category;

    final uri = Uri.parse(
      '$baseUrl/articles',
    ).replace(queryParameters: queryParams.isNotEmpty ? queryParams : null);

    try {
      final response = await _client
          .get(uri, headers: _getHeaders())
          .timeout(defaultTimeout);

      return _handleArticleListResponse(response, uri);
    } on SocketException {
      throw ApiException(
        'Tidak ada koneksi internet',
        type: ApiErrorType.network,
      );
    } on TimeoutException {
      throw ApiException('Waktu permintaan habis', type: ApiErrorType.timeout);
    } on FormatException catch (e) {
      throw ApiException(
        'Format data tidak valid: ${e.message}',
        type: ApiErrorType.parsing,
      );
    } catch (e) {
      throw ApiException(
        'Terjadi kesalahan tidak terduga: $e',
        type: ApiErrorType.unknown,
      );
    }
  }

  /// Fetches a single article by ID
  static Future<Article> fetchArticleById(int id) async {
    if (id <= 0) {
      throw ArgumentError('ID artikel harus lebih besar dari 0');
    }

    final uri = Uri.parse('$baseUrl/articles/$id');

    try {
      final response = await _client
          .get(uri, headers: _getHeaders())
          .timeout(defaultTimeout);

      return _handleSingleArticleResponse(response, uri);
    } on SocketException {
      throw ApiException(
        'Tidak ada koneksi internet',
        type: ApiErrorType.network,
      );
    } on TimeoutException {
      throw ApiException('Waktu permintaan habis', type: ApiErrorType.timeout);
    } on FormatException catch (e) {
      throw ApiException(
        'Format data tidak valid: ${e.message}',
        type: ApiErrorType.parsing,
      );
    } catch (e) {
      throw ApiException(
        'Terjadi kesalahan tidak terduga: $e',
        type: ApiErrorType.unknown,
      );
    }
  }

  // Private helper methods

  static Map<String, String> _getHeaders() {
    final token = _getToken(); // Ambil token dari GetStorage

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static List<Article> _handleArticleListResponse(
    http.Response response,
    Uri uri,
  ) {
    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      if (decoded.containsKey('data') && decoded['data'] is List) {
        final List<dynamic> jsonList = decoded['data'];
        return jsonList.map((json) => Article.fromJson(json)).toList();
      } else {
        throw ApiException(
          'Format JSON tidak sesuai. Field "data" tidak ditemukan atau bukan list.',
          type: ApiErrorType.parsing,
        );
      }
    } else {
      throw _handleHttpError(response, uri);
    }
  }

  static Article _handleSingleArticleResponse(http.Response response, Uri uri) {
    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      if (decoded['success'] == true && decoded.containsKey('data')) {
        return Article.fromJson(decoded['data']);
      } else {
        throw ApiException(
          'Artikel tidak ditemukan atau data tidak valid',
          type: ApiErrorType.server,
        );
      }
    } else {
      throw _handleHttpError(response, uri);
    }
  }

  static ApiException _handleHttpError(http.Response response, Uri uri) {
    switch (response.statusCode) {
      case 400:
        return ApiException(
          'Permintaan tidak valid',
          type: ApiErrorType.client,
        );
      case 401:
        return ApiException('Tidak memiliki akses', type: ApiErrorType.auth);
      case 403:
        return ApiException('Akses ditolak', type: ApiErrorType.auth);
      case 404:
        return ApiException(
          'Data tidak ditemukan',
          type: ApiErrorType.notFound,
        );
      case 408:
        return ApiException(
          'Waktu permintaan habis',
          type: ApiErrorType.timeout,
        );
      case 429:
        return ApiException(
          'Terlalu banyak permintaan',
          type: ApiErrorType.rateLimit,
        );
      case 500:
        return ApiException(
          'Kesalahan server internal',
          type: ApiErrorType.server,
        );
      case 502:
        return ApiException('Server tidak tersedia', type: ApiErrorType.server);
      case 503:
        return ApiException(
          'Layanan tidak tersedia',
          type: ApiErrorType.server,
        );
      default:
        return ApiException(
          'Kesalahan HTTP: ${response.statusCode} ${response.reasonPhrase}',
          type: ApiErrorType.server,
        );
    }
  }

  /// Dispose resources
  static void dispose() {
    _client.close();
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final ApiErrorType type;
  final int? statusCode;

  const ApiException(this.message, {required this.type, this.statusCode});

  @override
  String toString() => 'ApiException: $message';
}

// Enum for different types of API errors
enum ApiErrorType {
  network,
  timeout,
  auth,
  client,
  server,
  notFound,
  rateLimit,
  parsing,
  unknown,
}
