class UserModel {
  final String username;
  final String email;
  final String password;
  final String phonenumber;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.phonenumber,
  });

  // You can add helper methods if needed
  UserModel copyWith(
      {String? username,
      String? email,
      String? password,
      String? phonenumber}) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      phonenumber: phonenumber ?? this.phonenumber,
    );
  }

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, password: $password ,phonenumber: $phonenumber )';
  }
}
