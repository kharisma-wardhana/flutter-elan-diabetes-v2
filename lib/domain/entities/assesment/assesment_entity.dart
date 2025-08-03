import '../asam_urat_entity.dart';
import '../ginjal_entity.dart';
import '../gula_darah/gula_darah.dart';
import '../hb1ac_entity.dart';
import '../kolesterol_entity.dart';
import '../tensi_entity.dart';
import '../water_entity.dart';

class AssesmentEntity {
  final TensiEntity? tensi;
  final GulaDarahEntity? gula;
  final KolesterolEntity? kolesterol;
  final AsamUratEntity? asamUrat;
  final Hb1acEntity? hb1ac;
  final GinjalEntity? ginjal;
  final WaterEntity? water;

  AssesmentEntity({
    this.tensi,
    this.gula,
    this.kolesterol,
    this.asamUrat,
    this.hb1ac,
    this.ginjal,
    this.water,
  });
}
