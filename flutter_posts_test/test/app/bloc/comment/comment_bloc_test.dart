import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_posts_test/app/bloc/comment/comment_bloc.dart';
import 'package:flutter_posts_test/app/bloc/comment/comment_event.dart';
import 'package:flutter_posts_test/app/bloc/comment/comment_state.dart';
import 'package:flutter_posts_test/app/model/comment.dart';
import 'package:flutter_posts_test/app/repository/post/post_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late CommentBloc commentBloc;
  late PostRepository postRepository;
  setUp(() {
    postRepository = MockPostRepository();
    commentBloc = CommentBloc(postRepository: postRepository);
  });
  tearDown(() {
    commentBloc.close();
  });

  group('Testando contrutor', () {
    test('Deve constar no estado CommentsInitial', () {
      expect(commentBloc.state, isA<CommentInitial>());
    });
  });

  group('Testando evento LoadComments', () {
    Comment comment = Comment(
      postId: 1,
      id: 1,
      name: 'John',
      email: 'johndoe@gmail.com',
      body: 'Corpo do comentário',
    );

    blocTest(
      'Deve emitir os estados CommentLoading e posteriormente CommentLoaded',
      build: () => commentBloc,
      act: (bloc) {
        List<Comment> comments = List.generate(5, (index) => comment);
        when(() => postRepository.getComments(1)).thenAnswer((_) async => Either.right(comments));
        bloc.add(LoadComments(1));
      },
      expect:
          () => [
            isA<CommentLoading>(),
            isA<CommentLoaded>().having(
              (status) => status.comments.length,
              'Comentários',
              equals(5),
            ),
          ],
    );
  });
}
