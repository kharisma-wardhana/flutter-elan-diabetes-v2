import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/repository/doctor_repository.dart';
import '../datasource/remote/doctor_remote_datasource.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDatasource doctorRemoteDatasource;

  const DoctorRepositoryImpl({required this.doctorRemoteDatasource});

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctor() async {
    try {
      final doctors = await doctorRemoteDatasource.getAllDoctor();
      return Right(doctors.map((e) => e.mapDataToEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
