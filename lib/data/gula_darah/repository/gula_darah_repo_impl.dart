import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../domain/gula_darah/entity/gula_darah_entity.dart';
import '../../../domain/gula_darah/repository/gula_darah_repo.dart';
import '../datasource/remote/gula_darah_remote_datasource.dart';
import '../model/gula_darah.dart';

class GulaDarahRepoImpl implements GulaDarahRepository {
  final GulaDarahRemoteDataSource gulaDarahRemoteDataSource;

  GulaDarahRepoImpl({required this.gulaDarahRemoteDataSource});

  @override
  Future<Either<Failure, GulaDarahEntity>> addGulaDarah(
    String gulaDarahPuasa,
  ) async {
    try {
      GulaDarah gulaDarah = GulaDarah(
        level: gulaDarahPuasa,
        date: DateTime.now().toIso8601String(),
      );
      final result = await gulaDarahRemoteDataSource.addGulaDarah(gulaDarah);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GulaDarahEntity>>> getGulaDarah() {
    // TODO: implement getGulaDarah
    throw UnimplementedError();
  }
}
