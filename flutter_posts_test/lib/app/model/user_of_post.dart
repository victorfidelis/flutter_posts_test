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

  factory UserOfPost.fromMap(Map<String, dynamic> json) {
    return UserOfPost(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
    );
  } 

  UserOfPost copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    String? phone,
  }) {
    return UserOfPost(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  bool operator ==(covariant UserOfPost other) {
    return other.id == id &&
        other.name == name &&
        other.username == username &&
        other.email == email &&
        other.phone == phone;
  }
}