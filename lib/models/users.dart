class User {
  final String fullName;
  final String username;
  final String email;
  final String password;

  User({
    required this.fullName,
    required this.username,
    required this.email,
    required this.password,
  });

    factory User.empty() {
    return User(fullName: '', username: '', email: '', password: '');
    }

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json['fullName'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'username': username,
        'email': email,
        'password': password,
      };
}
