class OrderModel {
  final String orderId;
  final String keluhan;
  final int totalHarga;
  final String status;
  final String statusBayar;
  final String metodePembayaran;
  final String tanggal;
  final String jamMulai;
  final String jamSelesai;
  final String namaDokter;
  final String fotoDokter;

  OrderModel({
    required this.orderId,
    required this.keluhan,
    required this.totalHarga,
    required this.status,
    required this.statusBayar,
    required this.metodePembayaran,
    required this.tanggal,
    required this.jamMulai,
    required this.jamSelesai,
    required this.namaDokter,
    required this.fotoDokter,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'],
      keluhan: json['keluhan'],
      totalHarga: json['total_harga'],
      status: json['status'],
      statusBayar: json['status_bayar'],
      metodePembayaran: json['metode_pembayaran'],
      tanggal: json['vet_date']['tanggal'],
      jamMulai: json['vet_time']['jam_mulai'],
      jamSelesai: json['vet_time']['jam_selesai'],
      namaDokter: json['vet']['nama'],
      fotoDokter: json['vet']['foto'],
    );
  }
}
