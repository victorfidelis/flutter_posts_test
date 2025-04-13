import 'package:flutter_posts_test/app/model/comment.dart';

abstract class CommentsState {}

class CommentsInitial extends CommentsState {}
class CommentsLoading extends CommentsState {}
class CommentsLoaded extends CommentsState {
  final List<Comment> comments;
  CommentsLoaded(this.comments);
}
class CommentsFailure extends CommentsState {
  final String message;
  CommentsFailure(this.message);
}

