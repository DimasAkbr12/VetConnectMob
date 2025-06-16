class ArticleModel {
  final int id;
  final String judul;
  final String isi;
  final String gambar;

  ArticleModel({
    required this.id,
    required this.judul,
    required this.isi,
    required this.gambar,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      judul: json['judul'],
      isi: json['isi'],
      gambar: json['gambar'],
    );
  }
}
