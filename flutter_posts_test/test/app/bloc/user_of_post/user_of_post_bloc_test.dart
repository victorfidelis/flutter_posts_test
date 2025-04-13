import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_posts_test/app/bloc/user_of_post/user_of_post_bloc.dart';
import 'package:flutter_posts_test/app/bloc/user_of_post/user_of_post_event.dart';
import 'package:flutter_posts_test/app/bloc/user_of_post/user_of_post_state.dart';
import 'package:flutter_posts_test/app/model/user_of_post.dart';
import 'package:flutter_posts_test/app/repository/post/post_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late UserOfPostBloc userOfPostBloc;
  late PostRepository postRepository;
  setUp(() {
    postRepository = MockPostRepository();
    userOfPostBloc = UserOfPostBloc(postRepository: postRepository);
  });
  tearDown(() {
    userOfPostBloc.close();
  });

  group('Testando contrutor', () {
    test('Deve constar no estado UserOfPostInitial', () {
      expect(userOfPostBloc.state, isA<UserOfPostInitial>());
    });
  });

  group('Testando evento LoadUserOfPost', () {
    UserOfPost userOfPost = UserOfPost(
      id: 1,
      name: 'John',
      username: 'Doe',
      email: 'johndoe@gmail.com',
      phone: '123456789',
    );
    blocTest(
      'Deve emitir os estados UserOfPostLoading e posteriormente UserOfPostLoaded',
      build: () => userOfPostBloc,
      act: (bloc) {
        when(
          () => postRepository.getUserOfPost(1),
        ).thenAnswer((_) async => Either.right(userOfPost));
        bloc.add(LoadUserOfPost(1));
      },
      expect:
          () => [
            isA<UserOfPostLoading>(),
            isA<UserOfPostLoaded>().having(
              (status) => status.userOfPost,
              'Usuário do post',
              equals(userOfPost),
            ),
          ],
    );
  });
}
