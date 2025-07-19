import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/repository/video_repository.dart';
import '../datasource/remote/video_remote_datasource.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDatasource videoRemoteDatasource;

  VideoRepositoryImpl({required this.videoRemoteDatasource});

  @override
  Future<Either<Failure, List<VideoEntity>>> getAllVideo() async {
    try {
      final videos = await videoRemoteDatasource.getAllVideos();
      return Right(videos.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
