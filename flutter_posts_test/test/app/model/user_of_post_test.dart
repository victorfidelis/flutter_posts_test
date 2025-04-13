import 'package:flutter_posts_test/app/model/user_of_post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testando contrutor UserOfPost.fromMap', () {
    final Map<String, dynamic> map = {
      'id': 1,
      'name': 'John Doe',
      'username': 'johndoe',
      'email': 'johndoe@gmail.com',
      'phone': '123-456-7890',
    };
    test('Deve criar um usuário de post conforme o map', () {
      final UserOfPost user = UserOfPost.fromMap(map);
      expect(user.id, map['id']);
      expect(user.name, map['name']);
      expect(user.username, map['username']);
      expect(user.email, map['email']);
      expect(user.phone, map['phone']);
    });
  });
}
