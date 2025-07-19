import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../../core/usecase.dart';
import '../../domain/entities/activity/activity_entity.dart';
import '../../domain/entities/antropometri_entity.dart';
import '../../domain/entities/asam_urat_entity.dart';
import '../../domain/entities/ginjal_entity.dart';
import '../../domain/entities/gula_darah/gula_darah.dart';
import '../../domain/entities/hb1ac_entity.dart';
import '../../domain/entities/kolesterol_entity.dart';
import '../../domain/entities/tensi_entity.dart';
import '../../domain/entities/water_entity.dart';
import '../../domain/repository/assesment_repository.dart';
import '../datasource/remote/assesment_remote_datasource.dart';

class AssesmentRepositoryImpl implements AssesmentRepository {
  final AssesmentRemoteDatasource assesmentRemoteDatasource;

  const AssesmentRepositoryImpl({required this.assesmentRemoteDatasource});

  @override
  Future<Either<Failure, List<WaterEntity>>> getListWater(
    SearchParams params,
  ) async {
    try {
      final waters = await assesmentRemoteDatasource.getListWater(
        params.userId,
        params.date,
      );
      return Right(waters.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<WaterEntity>>> addWater(
    AddParams<WaterEntity> params,
  ) async {
    try {
      final waters = await assesmentRemoteDatasource.addWater(
        params.userId,
        params.data,
      );
      return Right(waters.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ActivityEntity>>> addActivity(
    AddParams<ActivityEntity> params,
  ) async {
    try {
      final data = await assesmentRemoteDatasource.addActivity(
        params.userId,
        params.data,
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ActivityEntity>>> getListActivity(
    SearchParams params,
  ) async {
    try {
      final activities = await assesmentRemoteDatasource.getListActivity(
        params.userId,
        params.date,
      );
      return Right(activities.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AntropometriEntity>> addAntropometri(
    AddParams<AntropometriEntity> params,
  ) async {
    try {
      final antropometri = await assesmentRemoteDatasource.addAntropometri(
        params.data,
      );
      return Right(antropometri.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AsamUratEntity>>> addAsamUrat(
    AddParams<AsamUratEntity> params,
  ) async {
    try {
      final asamUrat = await assesmentRemoteDatasource.addAsamUrat(
        params.userId,
        params.data,
      );
      return Right(asamUrat.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<GinjalEntity>>> addGinjal(
    AddParams<GinjalEntity> params,
  ) async {
    try {
      final ginjal = await assesmentRemoteDatasource.addGinjal(
        params.userId,
        params.data,
      );
      return Right(ginjal.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<GulaDarahEntity>>> addGulaDarah(
    AddParams<GulaDarahEntity> params,
  ) async {
    try {
      final gula = await assesmentRemoteDatasource.addGulaDarah(
        params.userId,
        params.data,
      );
      return Right(gula.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Hb1acEntity>>> addHb1ac(
    AddParams<Hb1acEntity> params,
  ) async {
    try {
      final hb1ac = await assesmentRemoteDatasource.addHb1ac(
        params.userId,
        params.data,
      );
      return Right(hb1ac.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<KolesterolEntity>>> addKolesterol(
    AddParams<KolesterolEntity> params,
  ) async {
    try {
      final kolesterol = await assesmentRemoteDatasource.addKolesterol(
        params.userId,
        params.data,
      );
      return Right(kolesterol.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TensiEntity>>> addTekananDarah(
    AddParams<TensiEntity> params,
  ) async {
    try {
      final tensi = await assesmentRemoteDatasource.addTekananDarah(
        params.userId,
        params.data,
      );
      return Right(tensi.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AsamUratEntity>>> getListAsamUrat(
    SearchParams params,
  ) async {
    try {
      final asamUrat = await assesmentRemoteDatasource.getListAsamUrat(
        params.userId,
        params.date,
      );
      return Right(asamUrat.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<GinjalEntity>>> getListGinjal(
    SearchParams params,
  ) async {
    try {
      final ginjal = await assesmentRemoteDatasource.getListGinjal(
        params.userId,
        params.date,
      );
      return Right(ginjal.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<GulaDarahEntity>>> getListGulaDarah(
    SearchParams params,
  ) async {
    try {
      final gula = await assesmentRemoteDatasource.getListGulaDarah(
        params.userId,
        params.date,
      );
      return Right(gula.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Hb1acEntity>>> getListHb1ac(
    SearchParams params,
  ) async {
    try {
      final hb1ac = await assesmentRemoteDatasource.getListHb1ac(
        params.userId,
        params.date,
      );
      return Right(hb1ac.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<KolesterolEntity>>> getListKolesterol(
    SearchParams params,
  ) async {
    try {
      final kolesterol = await assesmentRemoteDatasource.getListKolesterol(
        params.userId,
        params.date,
      );
      return Right(kolesterol.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TensiEntity>>> getListTekananDarah(
    SearchParams params,
  ) async {
    try {
      final tensi = await assesmentRemoteDatasource.getListTekananDarah(
        params.userId,
        params.date,
      );
      return Right(tensi.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AsamUratEntity>>> getGraphicAsamUrat(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final asamUrat = await assesmentRemoteDatasource.getGraphicAsamUrat(
        params.userId,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(asamUrat.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<GinjalEntity>>> getGraphicGinjal(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final data = await assesmentRemoteDatasource.getGraphicGinjal(
        params.userId,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<GulaDarahEntity>>> getGraphicGula(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final data = await assesmentRemoteDatasource.getGraphicGulaDarah(
        params.userId,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Hb1acEntity>>> getGraphicHb1ac(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final data = await assesmentRemoteDatasource.getGraphicHb1ac(
        params.userId,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<KolesterolEntity>>> getGraphicKolesterol(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final data = await assesmentRemoteDatasource.getGraphicKolesterol(
        params.userId,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TensiEntity>>> getGraphicTekananDarah(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final data = await assesmentRemoteDatasource.getGraphicTekananDarah(
        params.userId,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<WaterEntity>>> getGraphicWater(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final data = await assesmentRemoteDatasource.getGraphicWater(
        params.userId,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AntropometriEntity?>> getDetailAntropometri(
    int params,
  ) async {
    try {
      final data = await assesmentRemoteDatasource.getDetailAntropometri(
        params,
      );
      return Right(data != null ? data.toEntity() : null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
