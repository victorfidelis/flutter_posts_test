import 'package:flutter_posts_test/app/model/user.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> createUser(User user);
  Future<Either<Failure, Unit>> updateUser(User user);
  Future<Either<Failure, Unit>> deleteUser(String userId);
  Future<Either<Failure, User>> getUserByEmail(String email);
} 