import 'package:dartz/dartz.dart';
import 'package:elan/core/constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/error.dart';
import '../../core/usecase.dart';
import '../../domain/entities/activity/activity_entity.dart';
import '../../domain/entities/antropometri_entity.dart';
import '../../domain/entities/asam_urat_entity.dart';
import '../../domain/entities/assesment/assesment_entity.dart';
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
  final FlutterSecureStorage secureStorage;

  const AssesmentRepositoryImpl({
    required this.assesmentRemoteDatasource,
    required this.secureStorage,
  });

  Future<int> getUserID() async {
    final userID = await secureStorage.read(key: userIDKey);
    if (userID == null) {
      throw InvalidInputFailure("userID null");
    }

    return int.parse(userID);
  }

  @override
  Future<Either<Failure, AssesmentEntity>> getAssesment() async {
    try {
      final userID = await getUserID();
      final assesment = await assesmentRemoteDatasource.getAssesment(userID);
      return Right(assesment.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<WaterEntity>>> getListWater(
    SearchParams params,
  ) async {
    try {
      final userID = await getUserID();
      final waters = await assesmentRemoteDatasource.getListWater(
        userID,
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
      final userID = await getUserID();
      final waters = await assesmentRemoteDatasource.addWater(
        userID,
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
      final userID = await getUserID();
      final data = await assesmentRemoteDatasource.addActivity(
        userID,
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
      final userID = await getUserID();
      final activities = await assesmentRemoteDatasource.getListActivity(
        userID,
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
      final userID = await getUserID();
      final antropometri = await assesmentRemoteDatasource.addAntropometri(
        userID,
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
      final userID = await getUserID();
      final asamUrat = await assesmentRemoteDatasource.addAsamUrat(
        userID,
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
      final userID = await getUserID();
      final ginjal = await assesmentRemoteDatasource.addGinjal(
        userID,
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
      final userID = await getUserID();
      final gula = await assesmentRemoteDatasource.addGulaDarah(
        userID,
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
      final userID = await getUserID();
      final hb1ac = await assesmentRemoteDatasource.addHb1ac(
        userID,
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
      final userID = await getUserID();
      final kolesterol = await assesmentRemoteDatasource.addKolesterol(
        userID,
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
      final userID = await getUserID();
      final tensi = await assesmentRemoteDatasource.addTekananDarah(
        userID,
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
      final userID = await getUserID();
      final asamUrat = await assesmentRemoteDatasource.getListAsamUrat(
        userID,
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
      final userID = await getUserID();
      final ginjal = await assesmentRemoteDatasource.getListGinjal(
        userID,
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
      final userID = await getUserID();
      final gula = await assesmentRemoteDatasource.getListGulaDarah(
        userID,
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
      final userID = await getUserID();
      final hb1ac = await assesmentRemoteDatasource.getListHb1ac(
        userID,
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
      final userID = await getUserID();
      final kolesterol = await assesmentRemoteDatasource.getListKolesterol(
        userID,
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
      final userID = await getUserID();
      final tensi = await assesmentRemoteDatasource.getListTekananDarah(
        userID,
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
      final userID = await getUserID();
      final asamUrat = await assesmentRemoteDatasource.getGraphicAsamUrat(
        userID,
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
      final userID = await getUserID();
      final data = await assesmentRemoteDatasource.getGraphicGinjal(
        userID,
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
      final userID = await getUserID();
      final data = await assesmentRemoteDatasource.getGraphicGulaDarah(
        userID,
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
      final userID = await getUserID();
      final data = await assesmentRemoteDatasource.getGraphicHb1ac(
        userID,
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
      final userID = await getUserID();
      final data = await assesmentRemoteDatasource.getGraphicKolesterol(
        userID,
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
      final userID = await getUserID();
      final data = await assesmentRemoteDatasource.getGraphicTekananDarah(
        userID,
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
      final userID = await getUserID();
      final data = await assesmentRemoteDatasource.getGraphicWater(
        userID,
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
      return Right(data?.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
