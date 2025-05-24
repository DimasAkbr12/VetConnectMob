import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/article.dart';


class ArticleApiService {
  static const String baseUrl = 'https://vetconnectmob-production.up.railway.app/api';


  static Future<List<Article>> fetchArticles() async {
    final uri = Uri.parse('$baseUrl/articles');


    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 10));


      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);


        // Cek apakah field "data" ada dan berupa list
        if (decoded.containsKey('data') && decoded['data'] is List) {
          final List<dynamic> jsonList = decoded['data'];
          return jsonList.map((json) => Article.fromJson(json)).toList();
        } else {
          throw Exception('Format JSON tidak sesuai. Field "data" tidak ditemukan atau bukan list.');
        }
      } else {
        throw HttpException(
          'Failed to load articles: ${response.statusCode} ${response.reasonPhrase}',
          uri: uri,
        );
      }
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    } on TimeoutException {
      throw Exception('Waktu permintaan habis');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
