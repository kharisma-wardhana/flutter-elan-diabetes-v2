import 'package:elan/presentation/home/assesment/bloc/tekanan_darah/tensi_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/entities/tensi_entity.dart';
import '../../../../../domain/usecase/assesment/add_blood_pressure_usecase.dart';
import '../../../../../domain/usecase/assesment/get_list_blood_pressure_usecase.dart';

class TensiCubit extends Cubit<TensiState> {
  final GetListBloodPressureUseCase getListTekananDarahUseCase;
  final AddBloodPressureUseCase addBloodPressureUseCase;

  TensiCubit({
    required this.getListTekananDarahUseCase,
    required this.addBloodPressureUseCase,
  }) : super(TensiState(tensiState: ViewData.initial()));

  Future<void> getListTensi(String date) async {
    emit(TensiState(tensiState: ViewData.loading()));
    final result = await getListTekananDarahUseCase.call(
      SearchParams(date: date),
    );

    return result.fold(
      (failure) => emit(
        TensiState(
          tensiState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(TensiState(tensiState: ViewData.loaded(data: data)));
      },
    );
  }

  Future<void> addTensi(
    String date,
    String time,
    int sistole,
    int diastole,
  ) async {
    emit(TensiState(tensiState: ViewData.loading()));
    final result = await addBloodPressureUseCase.call(
      AddParams(
        data: TensiEntity(
          date: date,
          time: time,
          sistole: sistole,
          diastole: diastole,
        ),
      ),
    );

    return result.fold(
      (failure) => emit(
        TensiState(
          tensiState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(TensiState(tensiState: ViewData.loaded(data: data)));
      },
    );
  }
}
