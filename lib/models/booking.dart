class Booking {
  final int id;
  final String orderId;
  final String keluhan;
  final int totalHarga;
  final String status;
  final String statusBayar;
  final String metodePembayaran;
  final String createdAt;
  final Vet vet;
  final VetDate vetDate;
  final VetTime vetTime;

  Booking({
    required this.id,
    required this.orderId,
    required this.keluhan,
    required this.totalHarga,
    required this.status,
    required this.statusBayar,
    required this.metodePembayaran,
    required this.createdAt,
    required this.vet,
    required this.vetDate,
    required this.vetTime,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      orderId: json['order_id'],
      keluhan: json['keluhan'],
      totalHarga: json['total_harga'],
      status: json['status'],
      statusBayar: json['status_bayar'],
      metodePembayaran: json['metode_pembayaran'],
      createdAt: json['created_at'],
      vet: Vet.fromJson(json['vet']),
      vetDate: VetDate.fromJson(json['vet_date']),
      vetTime: VetTime.fromJson(json['vet_time']),
    );
  }
}

class Vet {
  final String nama;
  final String foto;

  Vet({
    required this.nama,
    required this.foto,
  });

  factory Vet.fromJson(Map<String, dynamic> json) {
    return Vet(
      nama: json['nama'],
      foto: json['foto'],
    );
  }
}

class VetDate {
  final String tanggal;

  VetDate({required this.tanggal});

  factory VetDate.fromJson(Map<String, dynamic> json) {
    return VetDate(
      tanggal: json['tanggal'],
    );
  }
}

class VetTime {
  final String jamMulai;
  final String jamSelesai;

  VetTime({required this.jamMulai, required this.jamSelesai});

  factory VetTime.fromJson(Map<String, dynamic> json) {
    return VetTime(
      jamMulai: json['jam_mulai'],
      jamSelesai: json['jam_selesai'],
    );
  }
}
