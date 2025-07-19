import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/entities/kolesterol_entity.dart';
import '../../../../../domain/usecase/assesment/add_kolesterol_usecase.dart';
import '../../../../../domain/usecase/assesment/get_list_kolesterol_usecase.dart';
import 'kolesterol_state.dart';

class KolesterolCubit extends Cubit<KolesterolState> {
  final GetListKolesterolUsecase getListKolesterolUsecase;
  final AddKolesterolUsecase addKolesterolUsecase;

  KolesterolCubit({
    required this.getListKolesterolUsecase,
    required this.addKolesterolUsecase,
  }) : super(KolesterolState(kolesterolState: ViewData.initial()));

  Future<void> getListKolesterol(String date) async {
    emit(KolesterolState(kolesterolState: ViewData.loading()));
    final result = await getListKolesterolUsecase.call(
      SearchParams(date: date),
    );

    return result.fold(
      (failure) => emit(
        KolesterolState(
          kolesterolState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(KolesterolState(kolesterolState: ViewData.loaded(data: data)));
      },
    );
  }

  Future<void> addKolesterol(String date, String type, int total) async {
    emit(KolesterolState(kolesterolState: ViewData.loading()));
    String typeInt = '0';
    if (type == 'HDL') {
      typeInt = '1';
    } else if (type == 'Trigliserida') {
      typeInt = '2';
    } else if (type == 'Total') {
      typeInt = '3';
    }
    final result = await addKolesterolUsecase.call(
      AddParams(
        data: KolesterolEntity(date: date, type: typeInt, total: total),
      ),
    );

    return result.fold(
      (failure) => emit(
        KolesterolState(
          kolesterolState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(KolesterolState(kolesterolState: ViewData.loaded(data: data)));
      },
    );
  }
}
