


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/failure.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/network_failures.dart';

class FirebaseInitializer {
  bool _isInitialized = false;

  static final FirebaseInitializer _instance = FirebaseInitializer._internal();
  FirebaseInitializer._internal();
  factory FirebaseInitializer() {
    return _instance;
  }

  Future<Either<Failure, Unit>> initialize() async {
    if (_isInitialized) {
      return Either.right(unit);
    }

    try {
      await Firebase.initializeApp();
      _isInitialized = true;
      return Either.right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'network-request-failed') {
        return Either.left(NetworkFailure('Sem conexão com a internet'));
      } else {
        return Either.left(Failure('Firebase error: ${e.message}'));
      }
    }
  }
}