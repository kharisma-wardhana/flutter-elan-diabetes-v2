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
    Map<String, String> params,
  ) async {
    try {
      final userID = params['userID'] ?? '0';
      if (userID == '0') {
        return Left(InvalidInputFailure('User ID is invalid'));
      }

      String kadar = params['gulaDarahPuasa']!.isNotEmpty
          ? params['gulaDarahPuasa']!
          : params['gulaDarahSewaktu']!;
      String datePart = DateTime.now().toIso8601String().split('T')[0];
      String timePart = DateTime.now()
          .toIso8601String()
          .split('T')[1]
          .split('.')[0];
      String type = params['gulaDarahPuasa']!.isNotEmpty ? '2' : '1';
      if (kadar.isEmpty) {
        return Left(
          InvalidInputFailure('Silahkan isi salah satu data gula darah'),
        );
      }
      GulaDarah gulaDarah = GulaDarah(
        userID: userID,
        tanggal: datePart,
        jam: timePart,
        kadar: kadar,
        type: type,
      );

      final result = await gulaDarahRemoteDataSource.addGulaDarah(
        userID,
        gulaDarah,
      );
      return Right(result.last.toEntity());
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
