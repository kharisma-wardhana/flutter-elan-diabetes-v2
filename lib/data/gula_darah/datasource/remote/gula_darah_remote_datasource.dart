import '../../../../core/api_service.dart';
import '../../../../core/error.dart';
import '../../model/gula_darah.dart';

abstract class GulaDarahRemoteDataSource {
  Future<GulaDarah> addGulaDarah(GulaDarah gulaDarah);
  Future<List<GulaDarah>> getGulaDarah();
}

class GulaDarahRemoteDataSourceImpl implements GulaDarahRemoteDataSource {
  // Assuming you have an ApiService to handle HTTP requests
  final ApiService apiService;

  GulaDarahRemoteDataSourceImpl({required this.apiService});

  @override
  Future<GulaDarah> addGulaDarah(GulaDarah gulaDarah) async {
    try {
      // Sending the GulaDarah data to the API
      final response = await apiService.postData('/gula_darah', {});
      // Assuming the response contains the created GulaDarah object
      return GulaDarah.fromJson(response.data);
    } on ServerException {
      // Handle server exceptions
      rethrow;
    }
  }

  @override
  Future<List<GulaDarah>> getGulaDarah() async {
    try {
      // Fetching the list of GulaDarah from the API
      final response = await apiService.fetchData('/gula_darah');
      return (response.data as List)
          .map((item) => GulaDarah.fromJson(item))
          .toList();
    } on ServerException {
      // Handle server exceptions
      rethrow;
    }
  }
}
