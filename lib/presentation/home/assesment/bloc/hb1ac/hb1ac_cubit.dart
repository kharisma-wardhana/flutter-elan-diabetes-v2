import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/entities/hb1ac_entity.dart';
import '../../../../../domain/usecase/assesment/add_hb_usecase.dart';
import '../../../../../domain/usecase/assesment/get_list_hb_usecase.dart';
import 'hb1ac_state.dart';

class Hb1acCubit extends Cubit<Hb1acState> {
  final GetListHbUsecase getListHbUsecase;
  final AddHbUsecase addHbUsecase;

  Hb1acCubit({required this.getListHbUsecase, required this.addHbUsecase})
    : super(Hb1acState(hbState: ViewData.initial()));

  Future<void> getListHb(String date) async {
    emit(Hb1acState(hbState: ViewData.loading()));
    final result = await getListHbUsecase.call(SearchParams(date: date));

    return result.fold(
      (failure) => emit(
        Hb1acState(
          hbState: ViewData.error(message: failure.message, failure: failure),
        ),
      ),
      (data) {
        emit(Hb1acState(hbState: ViewData.loaded(data: data)));
      },
    );
  }

  Future<void> addHba1c(String date, double total) async {
    emit(Hb1acState(hbState: ViewData.loading()));
    final result = await addHbUsecase.call(
      AddParams(
        data: Hb1acEntity(date: date, total: total),
      ),
    );

    return result.fold(
      (failure) => emit(
        Hb1acState(
          hbState: ViewData.error(message: failure.message, failure: failure),
        ),
      ),
      (data) {
        emit(Hb1acState(hbState: ViewData.loaded(data: data)));
      },
    );
  }
}
