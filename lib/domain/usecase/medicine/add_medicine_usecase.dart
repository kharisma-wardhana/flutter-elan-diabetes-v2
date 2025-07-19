import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/medicine_entity.dart';
import '../../repository/medicine_repository.dart';

class AddMedicineUseCase
    extends UseCase<List<MedicineEntity>, AddParams<MedicineEntity>> {
  final MedicineRepository medicineRepo;

  const AddMedicineUseCase({required this.medicineRepo});

  @override
  Future<Either<Failure, List<MedicineEntity>>> call(
    AddParams<MedicineEntity> params,
  ) async {
    return await medicineRepo.addMedicine(params);
  }
}
