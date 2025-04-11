import 'package:dio/dio.dart';
import 'package:flutter_posts_test/app/model/user_of_post.dart';
import 'package:flutter_posts_test/app/repository/user_of_post/user_of_post_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/failure.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/network_failures.dart';

class DioUserOfPostRepository implements UserOfPostRepository {
  final Dio dio = Dio();
  
  @override
  Future<Either<Failure, UserOfPost>> getUserOfPostById(int userId) async {
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
}