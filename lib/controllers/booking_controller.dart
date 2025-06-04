import 'package:get/get.dart';
import 'package:flutter_application_1/models/jadwal.dart';
import 'package:flutter_application_1/models/booking_request.dart';
import 'package:flutter_application_1/services/booking_api_service.dart';
import 'package:get_storage/get_storage.dart';

class BookingController extends GetxController {
  // Reactive state variables
  final _jadwalList = <Jadwal>[].obs;
  final _selectedDateId = RxnInt();
  final _selectedTimeId = RxnInt();
  final _keluhan = ''.obs;
  final _isLoading = false.obs;
  final _errorMessage = RxString('');

  final _box = GetStorage();

  // Getters
  List<Jadwal> get jadwalList => _jadwalList.value;
  int? get selectedDateId => _selectedDateId.value;
  int? get selectedTimeId => _selectedTimeId.value;
  String get keluhan => _keluhan.value;
  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;
  String? get token => _box.read('token');

  /// Fetches available schedules for a vet
  Future<void> fetchJadwal(int vetId) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final response = await BookingApiService.fetchVetSchedule(
        vetId: vetId,
        token: token,
      );

      _jadwalList.assignAll(response);
    } catch (e) {
      _errorMessage.value = 'Failed to load schedules: ${e.toString()}';
      Get.snackbar('Error', _errorMessage.value);
      rethrow;
    } finally {
      _isLoading.value = false;
    }
  }

  /// Selects a date and resets time selection
  void selectDate(int dateId) {
    _selectedDateId.value = dateId;
    _selectedTimeId.value = null; // Reset time when date changes
  }

  /// Selects a time slot
  void selectTime(int timeId) {
    _selectedTimeId.value = timeId;
  }

  /// Updates the complaint text
  void updateComplaint(String complaint) {
    _keluhan.value = complaint;
  }

  /// Validates if all required fields are filled
  bool _validateBookingFields() {
    if (_selectedDateId.value == null) {
      _errorMessage.value = 'Please select a date';
      return false;
    }

    if (_selectedTimeId.value == null) {
      _errorMessage.value = 'Please select a time slot';
      return false;
    }

    if (_keluhan.value.isEmpty) {
      _errorMessage.value = 'Please describe your complaint';
      return false;
    }

    return true;
  }

  /// Submits the booking request
  Future<int?> submitBooking({
    required int vetId,
    required int totalPrice,
    required String paymentMethod,
  }) async {
    if (!_validateBookingFields()) {
      Get.snackbar('Incomplete Data', _errorMessage.value!);
      return null;
    }

    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final bookingRequest = BookingRequest(
        vetId: vetId,
        vetDateId: _selectedDateId.value!,
        vetTimeId: _selectedTimeId.value!,
        keluhan: _keluhan.value,
        totalHarga: totalPrice,
        metodePembayaran: paymentMethod,
      );

      final bookingId = await BookingApiService.submitBooking(
        booking: bookingRequest,
        token: token,
      );

      if (bookingId == null) {
        _errorMessage.value = 'Failed to create booking';
        Get.snackbar('Error', _errorMessage.value);
      }

      return bookingId;
    } catch (e) {
      _errorMessage.value = 'Booking failed: ${e.toString()}';
      Get.snackbar('Error', _errorMessage.value);
      return null;
    } finally {
      _isLoading.value = false;
    }

    
  }

  /// Clears all selections
  void clearBooking() {
    _selectedDateId.value = null;
    _selectedTimeId.value = null;
    _keluhan.value = '';
    _errorMessage.value = '';
  }
}
