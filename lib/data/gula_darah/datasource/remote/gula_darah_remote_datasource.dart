import '../../../../core/api_service.dart';
import '../../../../core/error.dart';
import '../../model/gula_darah.dart';

abstract class GulaDarahRemoteDataSource {
  Future<List<GulaDarah>> addGulaDarah(String userID, GulaDarah gulaDarah);
  Future<List<GulaDarah>> getGulaDarah(String userID);
}

class GulaDarahRemoteDataSourceImpl implements GulaDarahRemoteDataSource {
  // Assuming you have an ApiService to handle HTTP requests
  final ApiService apiService;

  GulaDarahRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<GulaDarah>> addGulaDarah(
    String userID,
    GulaDarah gulaDarah,
  ) async {
    try {
      // Sending the GulaDarah data to the API
      final response = await apiService
          .postData('/users/$userID/blood-sugars', {
            "tanggal": gulaDarah.tanggal,
            "jam": gulaDarah.jam,
            "kadar": '${gulaDarah.kadar} mg/dL',
            "type": gulaDarah.type,
          });
      final responseData = response.data as Map<String, dynamic>;
      // Assuming the response contains the created GulaDarah object
      return (responseData['list'] as List)
          .map((e) => GulaDarah.fromJson(e))
          .toList();
    } on ServerException {
      // Handle server exceptions
      rethrow;
    }
  }

  @override
  Future<List<GulaDarah>> getGulaDarah(String userID) async {
    try {
      // Fetching the list of GulaDarah from the API
      final response = await apiService.fetchData(
        '/users/$userID/blood-sugars',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => GulaDarah.fromJson(e))
          .toList();
    } on ServerException {
      // Handle server exceptions
      rethrow;
    }
  }
}
