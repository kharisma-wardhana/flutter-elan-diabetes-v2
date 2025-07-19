import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/entities/water_entity.dart';
import '../../../../../domain/usecase/assesment/add_water_usecase.dart';
import '../../../../../domain/usecase/assesment/get_list_water_usecase.dart';
import 'water_state.dart';

class WaterCubit extends Cubit<WaterState> {
  final GetListWaterUseCase getListWaterUseCase;
  final AddWaterUseCase addWaterUseCase;

  WaterCubit({required this.getListWaterUseCase, required this.addWaterUseCase})
    : super(WaterState(waterState: ViewData.initial()));

  Future<void> getAllWater(String date) async {
    emit(WaterState(waterState: ViewData.loading()));
    final result = await getListWaterUseCase.call(SearchParams(date: date));

    return result.fold(
      (failure) => emit(
        WaterState(
          waterState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(WaterState(waterState: ViewData.loaded(data: data)));
      },
    );
  }

  Future<void> addWater(String date, int target, int total) async {
    emit(WaterState(waterState: ViewData.loading()));
    final result = await addWaterUseCase.call(
      AddParams(
        data: WaterEntity(date: date, target: target, total: total),
      ),
    );

    return result.fold(
      (failure) => emit(
        WaterState(
          waterState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(WaterState(waterState: ViewData.loaded(data: data)));
      },
    );
  }
}
