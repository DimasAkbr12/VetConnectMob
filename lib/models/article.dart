import 'dart:convert';


class Article {
  final int id;
  final int vetId;
  final String judul;
  final String isi;
  final List<String> gambar;
  final DateTime createdAt;


  Article({
    required this.id,
    required this.vetId,
    required this.judul,
    required this.isi,
    required this.gambar,
    required this.createdAt,
  });


  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      vetId: json['vet_id'],
      judul: json['judul'],
      isi: json['isi'],
      gambar: List<String>.from(jsonDecode(json['gambar'])), // decode string to List<String>
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
