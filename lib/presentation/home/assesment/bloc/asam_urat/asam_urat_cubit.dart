import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/entities/asam_urat_entity.dart';
import '../../../../../domain/usecase/assesment/add_asam_urat_usecase.dart';
import '../../../../../domain/usecase/assesment/get_list_asam_urat_usecase.dart';
import 'asam_urat_state.dart';

class AsamUratCubit extends Cubit<AsamUratState> {
  final GetListAsamUratUsecase getListAsamUratUsecase;
  final AddAsamUratUsecase addAsamUratUsecase;

  AsamUratCubit({
    required this.getListAsamUratUsecase,
    required this.addAsamUratUsecase,
  }) : super(AsamUratState(asamUratState: ViewData.initial()));

  Future<void> getListAsamUrat(String date) async {
    emit(AsamUratState(asamUratState: ViewData.loading()));
    final result = await getListAsamUratUsecase.call(SearchParams(date: date));

    return result.fold(
      (failure) => emit(
        AsamUratState(
          asamUratState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(AsamUratState(asamUratState: ViewData.loaded(data: data)));
      },
    );
  }

  Future<void> addAsamUrat(String date, double total) async {
    emit(AsamUratState(asamUratState: ViewData.loading()));
    final result = await addAsamUratUsecase.call(
      AddParams(
        data: AsamUratEntity(date: date, total: total),
      ),
    );

    return result.fold(
      (failure) => emit(
        AsamUratState(
          asamUratState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(AsamUratState(asamUratState: ViewData.loaded(data: data)));
      },
    );
  }
}
