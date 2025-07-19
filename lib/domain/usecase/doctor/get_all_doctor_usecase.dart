import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/doctor_entity.dart';
import '../../repository/doctor_repository.dart';

class GetAllDoctorUsecase extends UseCase<List<DoctorEntity>, NoParams> {
  final DoctorRepository doctorRepo;

  const GetAllDoctorUsecase({required this.doctorRepo});

  @override
  Future<Either<Failure, List<DoctorEntity>>> call(NoParams params) async {
    return await doctorRepo.getAllDoctor();
  }
}
