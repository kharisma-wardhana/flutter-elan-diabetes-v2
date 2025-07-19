import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/medicine_entity.dart';
import '../../repository/medicine_repository.dart';

class GetListMedicineUseCase
    extends UseCase<List<MedicineEntity>, SearchParams> {
  final MedicineRepository medicineRepo;

  GetListMedicineUseCase({required this.medicineRepo});

  @override
  Future<Either<Failure, List<MedicineEntity>>> call(
    SearchParams params,
  ) async {
    return await medicineRepo.getAllMedicine(params);
  }
}
