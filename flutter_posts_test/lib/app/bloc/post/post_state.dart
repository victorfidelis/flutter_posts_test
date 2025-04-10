
import 'package:flutter_posts_test/app/model/post.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded({required this.posts});
}

class PostFailure extends PostState {
  final String message;
  PostFailure(this.message);
}