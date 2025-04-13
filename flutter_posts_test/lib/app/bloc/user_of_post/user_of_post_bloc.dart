import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/user_of_post/user_of_post_event.dart';
import 'package:flutter_posts_test/app/bloc/user_of_post/user_of_post_state.dart';
import 'package:flutter_posts_test/app/repository/post/post_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either_extensions.dart';

class UserOfPostBloc extends Bloc<UserOfPostEvent, UserOfPostState> {
  PostRepository postRepository;
  UserOfPostBloc({required this.postRepository}) : super(UserOfPostInitial()) {
    on<LoadUserOfPost>(_onLoadUserOfPost);
  }

  Future<void> _onLoadUserOfPost(LoadUserOfPost event, Emitter<UserOfPostState> emit) async {
    emit(UserOfPostLoading());
    final userOfPostEither = await postRepository.getUserOfPost(event.userId);
    if (userOfPostEither.isLeft) {
      emit(UserOfPostFailure(userOfPostEither.left!.message));
    } else {
      emit(UserOfPostLoaded(userOfPostEither.right!));
    }
  }
}