
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/comment/comment_event.dart';
import 'package:flutter_posts_test/app/bloc/comment/comment_state.dart';
import 'package:flutter_posts_test/app/repository/post/post_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either_extensions.dart';

class CommentBloc extends Bloc<CommentsEvent, CommentsState> {
  
  final PostRepository postRepository;
  CommentBloc({required this.postRepository}) : super(CommentsInitial()) {
    on<LoadComments>(_onLoadComments);
  }
  
  Future<void> _onLoadComments(LoadComments event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());

    final commentsEither = await postRepository.getComments(event.postId);
    if (commentsEither.isLeft) {
      emit(CommentsFailure(commentsEither.left!.message));
    } else {
      emit(CommentsLoaded(commentsEither.right!));
    }
  }
}