// models/booking_detail.dart
import 'doctor.dart';
import 'jadwal.dart';

class BookingDetail {
  final int id;
  final String orderId;
  final int userId;
  final Dokter vet;
  final Jadwal vetDate;
  final WaktuJadwal vetTime;
  final String? keluhan;
  final int totalHarga;
  final String status;
  final String statusBayar;
  final String metodePembayaran;

  BookingDetail({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.vet,
    required this.vetDate,
    required this.vetTime,
    this.keluhan,
    required this.totalHarga,
    required this.status,
    required this.statusBayar,
    required this.metodePembayaran,
  });

  factory BookingDetail.fromJson(Map<String, dynamic> json) {
    return BookingDetail(
      id: json['id'],
      orderId: json['order_id'],
      userId: json['user_id'],
      vet: Dokter.fromJson(json['vet']),
      vetDate: Jadwal.fromJson(json['vet_date']),
      vetTime: WaktuJadwal.fromJson(json['vet_time']),
      keluhan: json['keluhan'],
      totalHarga: json['total_harga'],
      status: json['status'],
      statusBayar: json['status_bayar'],
      metodePembayaran: json['metode_pembayaran'],
    );
  }
}
