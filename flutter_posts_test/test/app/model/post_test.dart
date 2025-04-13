import 'package:flutter_posts_test/app/model/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testando construtor Post.fromMap', () {
    final Map<String, dynamic> map = {
      'userId': 1,
      'id': 1,
      'title': 'Título do Post',
      'body': 'Corpo do Post',
    };
    test('Deve criar um post conforme o map', () {
      final Post post = Post.fromMap(map);
      expect(post.userId, map['userId']);
      expect(post.id, map['id']);
      expect(post.title, map['title']);
      expect(post.body, map['body']);
    });
  });
}