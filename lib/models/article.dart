import 'dart:convert';

class Article {
  final int id;
  final int vetId;
  final String judul;
  final String isi;
  final List<String> gambar;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Vet? vet; // Tambahkan field vet

  Article({
    required this.id,
    required this.vetId,
    required this.judul,
    required this.isi,
    required this.gambar,
    required this.createdAt,
    required this.updatedAt,
    this.vet,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? 0,
      vetId: json['vet_id'] ?? 0,
      judul: json['judul'] ?? '',
      isi: json['isi'] ?? '',
      gambar: _parseGambar(json['gambar']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      vet: json['vet'] != null ? Vet.fromJson(json['vet']) : null,
    );
  }

  // Helper method untuk parsing gambar
  static List<String> _parseGambar(dynamic gambarData) {
    if (gambarData == null) return [];
    
    try {
      if (gambarData is String) {
        if (gambarData.isEmpty) return [];
        
        // Jika string dimulai dengan '[', kemungkinan JSON array
        if (gambarData.startsWith('[')) {
          final List<dynamic> decoded = jsonDecode(gambarData);
          return decoded.map((e) => e.toString()).toList();
        } else {
          // Jika string biasa, kembalikan sebagai single item
          return [gambarData];
        }
      } else if (gambarData is List) {
        return gambarData.map((e) => e.toString()).toList();
      }
    } catch (e) {
      print('Error parsing gambar: $e');
    }
    
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vet_id': vetId,
      'judul': judul,
      'isi': isi,
      'gambar': jsonEncode(gambar),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'vet': vet?.toJson(),
    };
  }
}

class Vet {
  final int id;
  final String nama;
  final String email;
  final String noTelp;
  final String alamat;
  final String str;
  final String sip;
  final String alumni;
  final int harga;
  final bool jenisKelamin; // true = laki-laki, false = perempuan
  final String? foto;
  final DateTime tglLahir;
  final String? deskripsi;
  final DateTime createdAt;
  final DateTime updatedAt;

  Vet({
    required this.id,
    required this.nama,
    required this.email,
    required this.noTelp,
    required this.alamat,
    required this.str,
    required this.sip,
    required this.alumni,
    required this.harga,
    required this.jenisKelamin,
    this.foto,
    required this.tglLahir,
    this.deskripsi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Vet.fromJson(Map<String, dynamic> json) {
    return Vet(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? '',
      email: json['email'] ?? '',
      noTelp: json['no_telp'] ?? '',
      alamat: json['alamat'] ?? '',
      str: json['STR'] ?? '',
      sip: json['SIP'] ?? '',
      alumni: json['alumni'] ?? '',
      harga: json['harga'] ?? 0,
      jenisKelamin: json['jenis_kelamin'] ?? true,
      foto: json['foto'],
      tglLahir: DateTime.parse(json['tgl_lahir']),
      deskripsi: json['deskripsi'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'no_telp': noTelp,
      'alamat': alamat,
      'STR': str,
      'SIP': sip,
      'alumni': alumni,
      'harga': harga,
      'jenis_kelamin': jenisKelamin,
      'foto': foto,
      'tgl_lahir': tglLahir.toIso8601String(),
      'deskripsi': deskripsi,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper getter untuk mendapatkan jenis kelamin sebagai string
  String get jenisKelaminString => jenisKelamin ? 'Laki-laki' : 'Perempuan';
  
  // Helper getter untuk mendapatkan URL foto lengkap
  String? get fotoUrl => foto != null ? 'http://10.0.2.2:8000/storage/foto_dokter/$foto' : null;
}