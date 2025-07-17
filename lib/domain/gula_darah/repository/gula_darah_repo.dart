import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../entity/gula_darah_entity.dart';

abstract class GulaDarahRepository {
  Future<Either<Failure, GulaDarahEntity>> addGulaDarah(
    Map<String, String> gulaDarah,
  );

  Future<Either<Failure, List<GulaDarahEntity>>> getGulaDarah();
}
