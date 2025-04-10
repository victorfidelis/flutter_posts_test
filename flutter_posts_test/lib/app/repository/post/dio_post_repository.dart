import 'package:dio/dio.dart';
import 'package:flutter_posts_test/app/model/post.dart';
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
      final List<Post> posts =
          (response.data as List).map((post) => Post.fromJson(post)).toList();
      return Either.right(posts);
    } else {
      return Either.left(ServerFailure('Ocorreu uma falha ao consultar os posts.'));
    }
  }
}
