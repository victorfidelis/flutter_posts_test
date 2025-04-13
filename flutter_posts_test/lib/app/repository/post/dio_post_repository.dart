import 'package:dio/dio.dart';
import 'package:flutter_posts_test/app/model/comment.dart';
import 'package:flutter_posts_test/app/model/post.dart';
import 'package:flutter_posts_test/app/model/user_of_post.dart';
import 'package:flutter_posts_test/app/repository/post/post_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/failure.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/network_failures.dart';

class DioPostRepository implements PostRepository {
  final Dio dio = Dio();

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    final Response response;
    try {
      response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    } catch (e) {
      return Either.left(ServerFailure('Ocorreu uma falha desconhecida ao consultar os posts.'));
    }

    if (response.statusCode == 200) {
      final List<Post> posts = (response.data as List).map((post) => Post.fromJson(post)).toList();
      return Either.right(posts);
    } else {
      return Either.left(ServerFailure('Ocorreu uma falha ao consultar os posts.'));
    }
  }
  
  @override
  Future<Either<Failure, UserOfPost>> getUserOfPost(int userId) async {
    final Response response;
    try {
      response = await dio.get('https://jsonplaceholder.typicode.com/users/$userId');
    } catch (e) {
      return Either.left(ServerFailure('Ocorreu uma falha desconhecida ao consultar o usuário.'));
    }

    if (response.statusCode == 200) {
      final user = UserOfPost.fromJson(response.data);
      return Either.right(user);
    } else {
      return Either.left(ServerFailure('Ocorreu uma falha ao consultar o usuário.'));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getComments(int postId) async {
    final Response response;
    try {
      response = await dio.get('https://jsonplaceholder.typicode.com/posts/$postId/comments');
    } catch (e) {
      return Either.left(ServerFailure('Ocorreu uma falha desconhecida ao consultar os posts.'));
    }

    if (response.statusCode == 200) {
      final List<Comment> comment =
          (response.data as List).map((comment) => Comment.fromJson(comment)).toList();
      return Either.right(comment);
    } else {
      return Either.left(ServerFailure('Ocorreu uma falha ao consultar os comentário.'));
    }
  }
}
