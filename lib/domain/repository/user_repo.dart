import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../entities/auth/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> register(
    String name,
    String email,
    String mobile,
    String dob,
    String gender,
  );
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, String>> logout();
}
