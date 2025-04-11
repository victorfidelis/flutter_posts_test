import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/post/post_event.dart';
import 'package:flutter_posts_test/app/bloc/post/post_state.dart';
import 'package:flutter_posts_test/app/repository/post/post_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either_extensions.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  
  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<PostLoad>(_onPostLoad);
    on<PostLoadMore>(_onPostLoadMore);
  }

  Future<void> _onPostLoad(PostLoad event, Emitter<PostState> emit) async {
    emit(PostLoading());

    final postEither = await postRepository.getPosts();
    if (postEither.isLeft) {
      emit(PostFailure(postEither.left!.message));
    } else {
      emit(PostLoaded(posts: postEither.right!));
    }
  } 
  
  Future<void> _onPostLoadMore(PostLoadMore event, Emitter<PostState> emit) async {
    final currentState = (state as PostLoaded).copyWith(onLoadMore: true);
    emit(currentState);
    await currentState.nextPage();
    emit(currentState.copyWith(onLoadMore: false));
  } 
}
