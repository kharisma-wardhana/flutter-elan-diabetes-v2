import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../entities/gula_darah/gula_darah.dart';

abstract class GulaDarahRepository {
  Future<Either<Failure, GulaDarahEntity>> addGulaDarah(
    Map<String, String> gulaDarah,
  );

  Future<Either<Failure, List<GulaDarahEntity>>> getGulaDarah();
}
