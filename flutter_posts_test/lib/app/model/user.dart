import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String name;
  String surname;
  String email;
  String profilePicture;

  User({
    this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.profilePicture,
  });

  factory User.fromFirebase(DocumentSnapshot doc) {
    Map<String, dynamic> map = (doc.data() as Map<String, dynamic>);

    return User(
      id: doc.id,
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
      profilePicture: map['profilePicture'],
    );
  }

  Map<String, dynamic> toFirebase() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    data['profile_picture'] = profilePicture;
    return data;
  }
}