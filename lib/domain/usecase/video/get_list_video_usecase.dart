import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/video_entity.dart';
import '../../repository/video_repository.dart';

class GetListVideoUsecase extends UseCase<List<VideoEntity>, NoParams> {
  final VideoRepository videoRepo;
  GetListVideoUsecase({required this.videoRepo});

  @override
  Future<Either<Failure, List<VideoEntity>>> call(NoParams params) async {
    return await videoRepo.getAllVideo();
  }
}
