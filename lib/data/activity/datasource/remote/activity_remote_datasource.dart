import '../../../../core/api_service.dart';
import '../../../../core/error.dart';
import '../../model/activity.dart';

abstract class ActivityRemoteDatasource {
  Future<Activity> addActivity(Activity activity);
  Future<List<Activity>> getActivities();
}

class ActivityRemoteDatasourceImpl implements ActivityRemoteDatasource {
  final ApiService apiService;

  ActivityRemoteDatasourceImpl({required this.apiService});

  @override
  Future<Activity> addActivity(Activity activity) async {
    try {
      // Sending the Activity data to the API
      final response = await apiService.postData('/users/activities', {});
      // Assuming the response contains the created Activity object
      return Activity.fromJson(response.data);
    } on ServerException {
      // Handle server exceptions
      rethrow;
    }
  }

  @override
  Future<List<Activity>> getActivities() async {
    try {
      // Sending the Activity data to the API
      final response = await apiService.fetchData('/users/activities');
      // Assuming the response contains the created Activity object
      // return Activity.fromJson(response.data);
      return List.empty();
    } on ServerException {
      // Handle server exceptions
      rethrow;
    }
  }
}
