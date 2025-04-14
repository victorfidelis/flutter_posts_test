import 'package:flutter/material.dart';
import 'package:flutter_posts_test/app/model/post.dart';
import 'package:flutter_posts_test/app/view/posts/widgets/post_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Post post = Post(userId: 1, id: 1, title: 'Title', body: 'Body');
  testWidgets('Deve carregar o card de postagem com o título e o corpo', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PostCard(post: post, onTap: (post) {}))),
    );

    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Body', findRichText: true), findsOne);
  });
}
