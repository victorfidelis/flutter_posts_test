import 'package:flutter_posts_test/app/model/user_of_post.dart';

abstract class UserOfPostState {}

class UserOfPostInitial extends UserOfPostState {}
class UserOfPostLoading extends UserOfPostState {}
class UserOfPostLoaded extends UserOfPostState {
  final UserOfPost userOfPost;
  UserOfPostLoaded(this.userOfPost);
}
class UserOfPostFailure extends UserOfPostState {
  final String message;
  UserOfPostFailure(this.message);
}
