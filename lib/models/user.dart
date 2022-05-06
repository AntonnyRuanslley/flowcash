class User {
  final String id;
  final String name;
  final String email;
  final int permission;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.permission,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      permission: json['permission']);
}
