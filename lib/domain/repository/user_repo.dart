import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> register(
    String name,
    String email,
    String mobile,
    String dob,
  );
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, String>> logout();
}
