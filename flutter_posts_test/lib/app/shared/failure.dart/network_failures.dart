import 'package:flutter_posts_test/app/shared/failure.dart/failure.dart';

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
} 

class ServerFailure extends Failure {
  ServerFailure(super.message);
}