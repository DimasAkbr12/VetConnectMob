import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_model.dart';

class OrderService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<OrderModel> getOrderById(int id, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/bookings/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return OrderModel.fromJson(data['data']);
    } else {
      throw Exception('Failed to load order');
    }
  }
}
