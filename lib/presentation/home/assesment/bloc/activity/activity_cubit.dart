import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/entities/activity/activity_entity.dart';
import '../../../../../domain/usecase/assesment/add_activity_usecase.dart';
import '../../../../../domain/usecase/assesment/get_list_activity_usecase.dart';
import 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final GetListActivityUseCase getListActivityUseCase;
  final AddActivityUseCase addActivityUseCase;

  ActivityCubit({
    required this.getListActivityUseCase,
    required this.addActivityUseCase,
  }) : super(ActivityState(activityState: ViewData.initial()));

  Future<void> getAllActivity(String date) async {
    emit(ActivityState(activityState: ViewData.loading()));
    final result = await getListActivityUseCase.call(SearchParams(date: date));

    return result.fold(
      (failure) => emit(
        ActivityState(
          activityState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(ActivityState(activityState: ViewData.loaded(data: data)));
      },
    );
  }

  Future<void> addActivity(
    String name,
    String date,
    int hour,
    int minute,
  ) async {
    emit(ActivityState(activityState: ViewData.loading()));
    final result = await addActivityUseCase.call(
      AddParams(
        data: ActivityEntity(
          name: name,
          date: date,
          hour: hour,
          minute: minute,
        ),
      ),
    );

    return result.fold(
      (failure) => emit(
        ActivityState(
          activityState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(ActivityState(activityState: ViewData.loaded(data: data)));
      },
    );
  }
}
