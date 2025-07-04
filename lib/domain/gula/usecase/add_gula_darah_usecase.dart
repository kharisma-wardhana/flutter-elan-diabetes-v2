import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../repository/gula_darah_repo.dart';

class AddGulaDarahUsecase implements UseCase<String, Map<String, String>> {
  final GulaDarahRepository gulaRepository;

  AddGulaDarahUsecase(this.gulaRepository);

  @override
  Future<Either<Failure, String>> call(Map<String, String> params) async {
    return await gulaRepository.addGulaDarah(params['gulaDarah']!);
  }
}
