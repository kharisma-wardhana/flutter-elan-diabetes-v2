import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/entities/antropometri_entity.dart';
import '../../../../../domain/usecase/assesment/add_antropometri_usecase.dart';
import '../../../../../domain/usecase/assesment/get_detail_antropometri_usecase.dart';
import 'antropometri_state.dart';

class AntropometriCubit extends Cubit<AntropometriState> {
  final AddAntropometriUseCase antropometriUseCase;
  final GetDetailAntropometriUsecase getDetailAntropometriUsecase;

  AntropometriCubit({
    required this.antropometriUseCase,
    required this.getDetailAntropometriUsecase,
  }) : super(AntropometriState(antropometriState: ViewData.initial()));

  Future<void> addAntropometri(
    double height,
    double weight,
    double stomach,
    double hand,
    double result,
    String status,
    String activity,
  ) async {
    emit(AntropometriState(antropometriState: ViewData.loading()));
    final response = await antropometriUseCase.call(
      AddParams(
        data: AntropometriEntity(
          height: height,
          weight: weight,
          stomach: stomach,
          hand: hand,
          result: result,
          status: status,
          activity: activity,
        ),
      ),
    );

    return response.fold(
      (failure) => emit(
        AntropometriState(
          antropometriState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(AntropometriState(antropometriState: ViewData.loaded(data: data)));
      },
    );
  }

  Future<void> getDetailAntropometri(int userId) async {
    emit(AntropometriState(antropometriState: ViewData.loading()));
    final response = await getDetailAntropometriUsecase.call(userId);

    return response.fold(
      (failure) => emit(
        AntropometriState(
          antropometriState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(AntropometriState(antropometriState: ViewData.loaded(data: data)));
      },
    );
  }
}
