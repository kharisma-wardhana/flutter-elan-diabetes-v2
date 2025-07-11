import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../entity/gula_darah_entity.dart';

abstract class GulaDarahRepository {
  Future<Either<Failure, GulaDarahEntity>> addGulaDarah(String gulaDarahPuasa);

  Future<Either<Failure, List<GulaDarahEntity>>> getGulaDarah();
}
