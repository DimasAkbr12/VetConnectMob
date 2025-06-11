import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/jadwal.dart';
import '../models/booking_request.dart';

const String baseUrl = 'http://10.0.2.2:8000'; // untuk emulator

class BookingApiService {
  static Future<List<Jadwal>> fetchVetSchedule({
    required int vetId,
    required String? token,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/vets/$vetId/jadwal'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData['jadwal'] as List)
          .map((data) => Jadwal.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load schedule: ${response.statusCode}');
    }
  }

  static Future<int?> submitBooking({
    required BookingRequest booking,
    required String? token,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/bookings'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(booking.toJson()),
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    print('Request Body: ${json.encode(booking.toJson())}');
    print('Token: $token');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      final bookingId = jsonData['data']['id'];
      return bookingId;
    } else {
      throw Exception('Booking failed: ${response.statusCode}');
    }
  }
}
