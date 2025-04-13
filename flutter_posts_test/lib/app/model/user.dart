
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
}