import '../../../core/api_service.dart';
import '../../../core/error.dart';
import '../../model/video/video.dart';

abstract class VideoRemoteDatasource {
  Future<List<Video>> getAllVideos();
}

class VideoRemoteDatasourceImpl implements VideoRemoteDatasource {
  final ApiService apiService;
  const VideoRemoteDatasourceImpl({required this.apiService});

  @override
  Future<List<Video>> getAllVideos() async {
    try {
      final response = await apiService.fetchData('/videos');
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Video.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }
}
