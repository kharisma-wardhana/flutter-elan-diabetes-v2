import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../entity/gula_darah_entity.dart';
import '../repository/gula_darah_repo.dart';

class AddGulaDarahUsecase
    implements UseCase<GulaDarahEntity, Map<String, String>> {
  final GulaDarahRepository gulaRepository;

  AddGulaDarahUsecase(this.gulaRepository);

  @override
  Future<Either<Failure, GulaDarahEntity>> call(
    Map<String, String> params,
  ) async {
    return await gulaRepository.addGulaDarah(params);
  }
}
