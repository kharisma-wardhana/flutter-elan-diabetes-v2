import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/medicine_entity.dart';
import '../../repository/medicine_repository.dart';

class UpdateStatusMedicineUseCase
    extends UseCase<List<MedicineEntity>, UpdateParams<int>> {
  final MedicineRepository medicineRepo;

  const UpdateStatusMedicineUseCase({required this.medicineRepo});

  @override
  Future<Either<Failure, List<MedicineEntity>>> call(
    UpdateParams<int> params,
  ) async {
    return await medicineRepo.updateStatusMedicine(params);
  }
}
