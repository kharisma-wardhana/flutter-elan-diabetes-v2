import '../../../core/api_service.dart';
import '../../../core/error.dart';
import '../../model/doctor/doctor.dart';

abstract class DoctorRemoteDatasource {
  Future<List<Doctor>> getAllDoctor();
}

class DoctorRemoteDatasourceImpl implements DoctorRemoteDatasource {
  final ApiService apiService;

  const DoctorRemoteDatasourceImpl({required this.apiService});

  @override
  Future<List<Doctor>> getAllDoctor() async {
    try {
      final response = await apiService.fetchData('/doctors');
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Doctor.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }
}
