class Article {
  final int id;
  final String judul;
  final String gambar;

  Article({required this.id, required this.judul, required this.gambar});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      judul: json['judul'],
      gambar:
          json['gambar'].toString().startsWith('http')
              ? json['gambar']
              : 'http://10.0.2.2:8000${json['gambar']}',
    );
  }
}
