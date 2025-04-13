import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_posts_test/app/bloc/post/post_bloc.dart';
import 'package:flutter_posts_test/app/bloc/post/post_event.dart';
import 'package:flutter_posts_test/app/bloc/post/post_state.dart';
import 'package:flutter_posts_test/app/model/post.dart';
import 'package:flutter_posts_test/app/repository/post/post_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late PostBloc postBloc;
  late PostRepository postRepository;
  setUp(() {
    postRepository = MockPostRepository();
    postBloc = PostBloc(postRepository: postRepository);
  });

  tearDown(() {
    postBloc.close();
  });

  group('Testando contrutor', () {
    test('Deve constar no estado PostInitial', () {
      expect(postBloc.state, isA<PostInitial>());
    });
  });

  group('Testando evento LoadPosts', () {
    blocTest(
      'Deve emitir os estados PostLoading e posteriormente PostLoaded com 10 posts',
      build: () => postBloc,
      act: (bloc) {
        Post post = Post(userId: 1, id: 1, title: 'Título', body: 'Corpo');
        List<Post> posts = List.generate(100, (index) => post.copyWith(id: index));
        when(() => postRepository.getPosts()).thenAnswer((_) async => Either.right(posts));
        bloc.add(LoadPosts());
      },
      expect:
          () => [
            isA<PostLoading>(),
            isA<PostLoaded>().having((state) => state.posts.length, 'posts', 10),
          ],
    );
  });

  group('Testando evento LoadMorePosts', () {
    blocTest(
      'Deve emitir os estados PostLoading e posteriormente PostLoaded com 20 posts',
      build: () => postBloc,
      act: (bloc) {
        Post post = Post(userId: 1, id: 1, title: 'Título', body: 'Corpo');
        List<Post> posts = List.generate(100, (index) => post.copyWith(id: index));
        postBloc.emit(PostLoaded(posts: posts));
        bloc.add(LoadMorePosts());
      },
      wait: const Duration(milliseconds: 1200),
      expect:
          () => [
            isA<PostLoaded>().having((state) => state.posts.length, 'posts', 10),
            isA<PostLoaded>().having((state) => state.onLoadMore, 'Carregando mais posts', isTrue),
            isA<PostLoaded>().having((state) => state.posts.length, 'posts', 20),
          ],
    );
  });
}
