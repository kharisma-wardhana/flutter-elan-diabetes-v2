import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/entities/gula_darah/gula_darah.dart';
import '../../../../../domain/usecase/assesment/add_blood_sugar_usecase.dart';
import '../../../../../domain/usecase/assesment/get_list_blood_sugar_usecase.dart';
import 'gula_state.dart';

class GulaCubit extends Cubit<GulaState> {
  final GetListBloodSugarUseCase getListBloodSugarUseCase;
  final AddBloodSugarUseCase addBloodSugarUseCase;

  GulaCubit({
    required this.getListBloodSugarUseCase,
    required this.addBloodSugarUseCase,
  }) : super(GulaState(gulaState: ViewData.initial()));

  Future<void> getListGula(String date) async {
    emit(GulaState(gulaState: ViewData.loading()));
    final result = await getListBloodSugarUseCase.call(
      SearchParams(date: date),
    );

    return result.fold(
      (failure) => emit(
        GulaState(
          gulaState: ViewData.error(message: failure.message, failure: failure),
        ),
      ),
      (data) {
        emit(GulaState(gulaState: ViewData.loaded(data: data)));
      },
    );
  }

  Future<void> addGula(
    String date,
    String time,
    String type,
    String total,
  ) async {
    emit(GulaState(gulaState: ViewData.loading()));
    final result = await addBloodSugarUseCase.call(
      AddParams(
        data: GulaDarahEntity(
          date: date,
          time: time,
          type: int.parse(type),
          total: total,
        ),
      ),
    );

    return result.fold(
      (failure) => emit(
        GulaState(
          gulaState: ViewData.error(message: failure.message, failure: failure),
        ),
      ),
      (data) {
        emit(GulaState(gulaState: ViewData.loaded(data: data)));
      },
    );
  }
}
