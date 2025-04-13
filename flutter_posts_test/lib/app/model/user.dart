
class User {
  String name;
  String surname;
  String email;
  String profilePicture;
  String backgroundImage;
  int age;
  int numberOfPosts;
  List<String> likes;

  User({
    required this.name,
    required this.surname,
    required this.email,
    required this.profilePicture,
    required this.backgroundImage,
    required this.age,
    required this.numberOfPosts,
    required this.likes,
  });

  String get fullName => '$name $surname';

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
      profilePicture: map['profilePicture'],
      backgroundImage: map['backgroundImage'],
      age: map['age'],
      numberOfPosts: map['numberOfPosts'],
      likes: map['likes'].map<String>((e) => e.toString()).toList(),
    );
  }

  User copyWith({
    String? name,
    String? surname,
    String? email,
    String? profilePicture,
    String? backgroundImage,
    int? age,
    int? numberOfPosts,
    List<String>? likes,
  }) {
    return User(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      age: age ?? this.age,
      numberOfPosts: numberOfPosts ?? this.numberOfPosts,
      likes: likes ?? this.likes,
    );
  }

  @override
  bool operator ==(covariant User other) {
    return other.name == name &&
        other.surname == surname &&
        other.email == email &&
        other.profilePicture == profilePicture &&
        other.backgroundImage == backgroundImage &&
        other.age == age &&
        other.numberOfPosts == numberOfPosts;
  }
}