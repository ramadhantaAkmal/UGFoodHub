class AccountModel {
  final int id;
  final String nama;
  final String email;
  final String noWa;
  final String image;
  final String username;
  final String password;

  const AccountModel({
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

  // @override
  // String toString() {
  //   // TODO: implement toString
  //   return 'id $id, nama $nama, username => $username email $email, password $password';
  // }
}
