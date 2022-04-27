class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final int permission;
  String? token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.permission,
    this.token,
  });
}
