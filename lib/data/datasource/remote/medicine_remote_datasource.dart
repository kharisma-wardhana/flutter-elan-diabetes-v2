import '../../../core/api_service.dart';
import '../../../core/error.dart';
import '../../../domain/entities/medicine_entity.dart';
import '../../model/medicine/medicine.dart';

abstract class MedicineRemoteDatasource {
  Future<List<Medicine>> getAllMedicine(int userId, String date);
  Future<List<Medicine>> addMedicine(int userId, MedicineEntity medicine);
  Future<List<Medicine>> updateStatusMedicine(
    int userId,
    int medicineId,
    int status,
  );
}

class MedicineRemoteDatasourceImpl implements MedicineRemoteDatasource {
  final ApiService apiService;
  MedicineRemoteDatasourceImpl({required this.apiService});

  @override
  Future<List<Medicine>> addMedicine(
    int userId,
    MedicineEntity medicine,
  ) async {
    try {
      final response = await apiService.postData('/users/$userId/medicines', {
        'users_id': userId,
        'nama': medicine.name,
        'tanggal': medicine.date,
        'durasi': medicine.duration,
        'dosis': medicine.dosis,
        'type': medicine.type,
      });
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Medicine.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Medicine>> getAllMedicine(int userId, String date) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/medicines?date=$date',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Medicine.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Medicine>> updateStatusMedicine(
    int userId,
    int medicineId,
    int status,
  ) async {
    try {
      final response = await apiService.patchData(
        '/users/$userId/medicines/$medicineId',
        {'status': status},
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Medicine.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }
}
