class AccountModel {
  final int id;
  final String nama;
  final String email;
  final String noWa;
  final String image;
  final String username;
  final String password;

  AccountModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.noWa,
    required this.image,
    required this.username,
    required this.password,
  });

  static AccountModel fromJson(json) => AccountModel(
        id: json['id'],
        nama: json['nama'],
        email: json['email'],
        noWa: json['noWa'],
        image: json['image'],
        username: json['username'],
        password: json['password'],
      );
}
