import 'package:flutter_posts_test/app/model/comment.dart';
import 'package:flutter_posts_test/app/model/post.dart';
import 'package:flutter_posts_test/app/model/user_of_post.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/failure.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts(); 
  Future<Either<Failure, UserOfPost>> getUserOfPost(int userId);
  Future<Either<Failure, List<Comment>>> getComments(int postId);
}