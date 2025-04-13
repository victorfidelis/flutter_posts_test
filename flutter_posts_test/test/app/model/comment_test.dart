import 'package:flutter_posts_test/app/model/comment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testando construtor Comment.fromMap', () {
    final Map<String, dynamic> map = {
      'postId': 1,
      'id': 1,
      'name': 'John Doe',
      'email': 'johndoe@gmail.com',
      'body': 'This is a comment body.',
    };
    test('Deve criar um comentário conforme o map', () {
      final Comment comment = Comment.fromMap(map);
      expect(comment.postId, map['postId']);
      expect(comment.id, map['id']);
      expect(comment.name, map['name']);
      expect(comment.email, map['email']);
      expect(comment.body, map['body']);
    });
  });
}