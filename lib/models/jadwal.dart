class Jadwal {
  final int tanggalId;
  final String tanggal;
  final List<WaktuJadwal> waktuList;

  Jadwal({
    required this.tanggalId,
    required this.tanggal,
    required this.waktuList,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      tanggalId: json['tanggal_id'],
      tanggal: json['tanggal'],
      waktuList: (json['waktu'] as List)
          .map((e) => WaktuJadwal.fromJson(e))
          .toList(),
    );
  }
}

class WaktuJadwal {
  final int waktuId;
  final String jam;

  WaktuJadwal({
    required this.waktuId,
    required this.jam,
  });

  factory WaktuJadwal.fromJson(Map<String, dynamic> json) {
    return WaktuJadwal(
      waktuId: json['waktu_id'],
      jam: json['jam'],
    );
  }
}
