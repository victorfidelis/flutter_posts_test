class UserOfPost {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;

  UserOfPost({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
  });

  factory UserOfPost.fromJson(Map<String, dynamic> json) {
    return UserOfPost(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}