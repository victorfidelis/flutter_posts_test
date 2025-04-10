import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/post/post_event.dart';
import 'package:flutter_posts_test/app/bloc/post/post_state.dart';
import 'package:flutter_posts_test/app/repository/post/post_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either_extensions.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<PostLoad>(_onPostLoad);
  }

  final PostRepository postRepository;

  Future<void> _onPostLoad(PostLoad event, Emitter<PostState> emit) async {
    emit(PostLoading());

    final postEither = await postRepository.getPosts();
    if (postEither.isLeft) {
      emit(PostFailure(postEither.left!.message));
    } else {
      emit(PostLoaded(posts: postEither.right!));
    }
  }
}
