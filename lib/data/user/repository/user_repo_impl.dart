import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../domain/auth/entity/user_entity.dart';
import '../../../domain/auth/repository/user_repo.dart';
import '../datasource/remote/user_remote_datasource.dart';

class UserRepoImpl implements UserRepository {
  final UserRemoteDatasource remoteDataSource;

  UserRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> register(
    String name,
    String email,
    String mobile,
    String dob,
  ) async {
    try {
      final user = await remoteDataSource.register(name, email, mobile, dob);
      return Right(user.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.login(email, password);
      return Right(user.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final message = await remoteDataSource.logout();
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
