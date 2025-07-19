import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../entities/video_entity.dart';

abstract class VideoRepository {
  const VideoRepository();

  Future<Either<Failure, List<VideoEntity>>> getAllVideo();
}
