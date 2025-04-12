import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_posts_test/app/model/user.dart';
import 'package:flutter_posts_test/app/repository/config/firebase_initializer.dart';
import 'package:flutter_posts_test/app/repository/user/user_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_posts_test/app/shared/either/either_extensions.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/auth_failures.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/failure.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/network_failures.dart';

class FirebaseUserRepository implements UserRepository{
  final _firebaseInitializer = FirebaseInitializer();

  @override
  Future<Either<Failure, User>> getUserByEmail(String email) async{
    final initializeEither = await _firebaseInitializer.initialize();
    if (initializeEither.isLeft) {
      return Either.left(initializeEither.left);
    }
    
    try {
      final usersCollection = FirebaseFirestore.instance.collection('users');
      QuerySnapshot querySnap =
          await usersCollection.where('email', isEqualTo: email).limit(1).get();

      if (querySnap.docs.isEmpty) {
        return Either.left(UserNotFoundFailure('Usuário não encontrado'));
      } else {
        User user = User.fromFirebase(querySnap.docs[0]);
        return Either.right(user);
      }
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return Either.left(NetworkFailure('Sem conexão com a internet'));
      } else {
        return Either.left(Failure('Firestore error: ${e.message}'));
      }
    }
  }
}