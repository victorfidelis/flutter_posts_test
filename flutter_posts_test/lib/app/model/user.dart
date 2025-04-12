import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String name;
  String surname;
  String email;
  String profilePicture;
  String backgroundImage;
  int age;
  int numberOfPosts;
  List<String> likes;

  User({
    this.id,
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

  factory User.fromFirebase(DocumentSnapshot doc) {
    Map<String, dynamic> map = (doc.data() as Map<String, dynamic>);

    return User(
      id: doc.id,
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