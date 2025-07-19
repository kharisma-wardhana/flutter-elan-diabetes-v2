import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../entities/doctor_entity.dart';

abstract class DoctorRepository {
  const DoctorRepository();

  Future<Either<Failure, List<DoctorEntity>>> getAllDoctor();
}
