class UserProfile {
  final int id;
  final String name;
  final String email;
  final String noTelp;
  final int umur;
  final String alamat;
  final String? foto;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.noTelp,
    required this.umur,
    required this.alamat,
    this.foto,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      noTelp: json['no_telp'],
      umur: json['umur'],
      alamat: json['alamat'],
      foto: json['foto'],
    );
  }
}
