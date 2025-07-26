import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../../core/usecase.dart';
import '../entities/activity/activity_entity.dart';
import '../entities/antropometri_entity.dart';
import '../entities/asam_urat_entity.dart';
import '../entities/assesment/assesment_entity.dart';
import '../entities/ginjal_entity.dart';
import '../entities/gula_darah/gula_darah.dart';
import '../entities/hb1ac_entity.dart';
import '../entities/kolesterol_entity.dart';
import '../entities/tensi_entity.dart';
import '../entities/water_entity.dart';

abstract class AssesmentRepository {
  Future<Either<Failure, AssesmentEntity>> getAssesment();
  Future<Either<Failure, List<WaterEntity>>> getGraphicWater(
    SearchParams params,
  );
  Future<Either<Failure, List<WaterEntity>>> getListWater(SearchParams params);
  Future<Either<Failure, List<WaterEntity>>> addWater(
    AddParams<WaterEntity> params,
  );

  Future<Either<Failure, List<ActivityEntity>>> getListActivity(
    SearchParams params,
  );

  Future<Either<Failure, List<ActivityEntity>>> addActivity(
    AddParams<ActivityEntity> params,
  );

  Future<Either<Failure, AntropometriEntity>> addAntropometri(
    AddParams<AntropometriEntity> params,
  );

  Future<Either<Failure, AntropometriEntity?>> getDetailAntropometri(
    int params,
  );

  Future<Either<Failure, List<GulaDarahEntity>>> getGraphicGula(
    SearchParams params,
  );
  Future<Either<Failure, List<GulaDarahEntity>>> getListGulaDarah(
    SearchParams params,
  );

  Future<Either<Failure, List<GulaDarahEntity>>> addGulaDarah(
    AddParams<GulaDarahEntity> params,
  );

  Future<Either<Failure, List<TensiEntity>>> getGraphicTekananDarah(
    SearchParams params,
  );
  Future<Either<Failure, List<TensiEntity>>> getListTekananDarah(
    SearchParams params,
  );

  Future<Either<Failure, List<TensiEntity>>> addTekananDarah(
    AddParams<TensiEntity> params,
  );

  Future<Either<Failure, List<KolesterolEntity>>> getGraphicKolesterol(
    SearchParams params,
  );
  Future<Either<Failure, List<KolesterolEntity>>> getListKolesterol(
    SearchParams params,
  );

  Future<Either<Failure, List<KolesterolEntity>>> addKolesterol(
    AddParams<KolesterolEntity> params,
  );

  Future<Either<Failure, List<AsamUratEntity>>> getGraphicAsamUrat(
    SearchParams params,
  );
  Future<Either<Failure, List<AsamUratEntity>>> getListAsamUrat(
    SearchParams params,
  );

  Future<Either<Failure, List<AsamUratEntity>>> addAsamUrat(
    AddParams<AsamUratEntity> params,
  );

  Future<Either<Failure, List<Hb1acEntity>>> getGraphicHb1ac(
    SearchParams params,
  );
  Future<Either<Failure, List<Hb1acEntity>>> getListHb1ac(SearchParams params);

  Future<Either<Failure, List<Hb1acEntity>>> addHb1ac(
    AddParams<Hb1acEntity> params,
  );

  Future<Either<Failure, List<GinjalEntity>>> getGraphicGinjal(
    SearchParams params,
  );
  Future<Either<Failure, List<GinjalEntity>>> getListGinjal(
    SearchParams params,
  );

  Future<Either<Failure, List<GinjalEntity>>> addGinjal(
    AddParams<GinjalEntity> params,
  );
}
