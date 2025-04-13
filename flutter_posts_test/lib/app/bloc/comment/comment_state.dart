import 'package:flutter_posts_test/app/model/comment.dart';

abstract class CommentState {}

class CommentInitial extends CommentState {}
class CommentLoading extends CommentState {}
class CommentLoaded extends CommentState {
  final List<Comment> comments;
  CommentLoaded(this.comments);
}
class CommentFailure extends CommentState {
  final String message;
  CommentFailure(this.message);
}

