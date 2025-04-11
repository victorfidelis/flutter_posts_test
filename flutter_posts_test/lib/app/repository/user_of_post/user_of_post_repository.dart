import 'package:flutter_posts_test/app/model/user_of_post.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/failure.dart';

abstract class UserOfPostRepository {
  Future<Either<Failure, UserOfPost>> getUserOfPostById(int userId);
}