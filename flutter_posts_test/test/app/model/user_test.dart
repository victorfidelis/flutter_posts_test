import 'package:flutter_posts_test/app/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testando construtor User.fromMap', () {
    final Map<String, dynamic> map = {
      'name': 'John',
      'surname': 'Doe',
      'email': 'johndoe@gmail.com',
      'profilePicture': 'https://example.com/profile.jpg',
      'backgroundImage': 'https://example.com/background.jpg',
      'age': 30,
      'numberOfPosts': 5,
      'likes': ['Filmes', 'Tecnologia', 'Música'],
    };

    test('Deve criar um usuário conforme o map', () {
      final User user = User.fromMap(map);
      expect(user.name, map['name']);
      expect(user.surname, map['surname']);
      expect(user.email, map['email']);
      expect(user.profilePicture, map['profilePicture']);
      expect(user.backgroundImage, map['backgroundImage']);
      expect(user.age, map['age']);
      expect(user.numberOfPosts, map['numberOfPosts']);
      expect(user.likes, map['likes'].map<String>((e) => e.toString()).toList());
    });
  });

  group('Testando propriedade get fullName', () {
    User user = User(name: 'John', surname: 'Doe', email: '', profilePicture: '', backgroundImage: '', age: 30, numberOfPosts: 30, likes: []);
    test('Deve retornar o nome completo do usuário', () {
      expect(user.fullName, 'John Doe');
    });
  });
}
