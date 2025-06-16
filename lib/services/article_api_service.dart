import 'dart:convert';
import 'package:flutter_application_1/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ArticleService {
  final box = GetStorage();
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<Article>> fetchAllArticles() async {
    final token = box.read('token');
    final response = await http.get(
      Uri.parse('$baseUrl/articles'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List data = jsonData['data'];
      return data.map((item) => Article.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat artikel');
    }
  }

  Future<Map<String, dynamic>> fetchArticleDetail(int id) async {
    final token = box.read('token');
    final response = await http.get(
      Uri.parse('$baseUrl/articles/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['data'];
    } else {
      throw Exception('Artikel tidak ditemukan');
    }
  }
}
