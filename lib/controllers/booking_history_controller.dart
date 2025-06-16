import 'package:get/get.dart';
import '../models/booking.dart';
import '../services/booking_api_service.dart';
import 'package:get_storage/get_storage.dart';

class BookingHistoryController extends GetxController {
  final _bookings = <Booking>[].obs; // Ubah ke List<Booking>
  final _isLoading = false.obs;
  final _error = ''.obs;

  final _box = GetStorage();
  String? get token => _box.read('token');
  int? get userId => _box.read('user_id');

  List<Booking> get bookings => _bookings; // Ubah ke List<Booking>
  bool get isLoading => _isLoading.value;
  String get error => _error.value;

  Future<void> fetchBookingHistory() async {
    try {
      _isLoading.value = true;
      _error.value = '';

      if (userId == null || token == null) {
        _error.value = 'User not logged in';
        return;
      }

      final result = await BookingApiService.fetchAllBookings(
        userId: userId!,
        token: token!,
      );

      _bookings.value = result; // Simpan list bookings
    } catch (e) {
      _error.value = 'Failed to fetch bookings: $e';
    } finally {
      _isLoading.value = false;
    }
  }
}