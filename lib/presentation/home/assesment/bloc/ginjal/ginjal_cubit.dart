import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/entities/ginjal_entity.dart';
import '../../../../../domain/usecase/assesment/add_ginjal_usecase.dart';
import '../../../../../domain/usecase/assesment/get_list_ginjal_usecase.dart';
import 'ginjal_state.dart';

class GinjalCubit extends Cubit<GinjalState> {
  final GetListGinjalUsecase getListGinjalUsecase;
  final AddGinjalUsecase addGinjalUsecase;

  GinjalCubit({
    required this.getListGinjalUsecase,
    required this.addGinjalUsecase,
  }) : super(GinjalState(ginjalState: ViewData.initial()));

  Future<void> getListGinjal(String date) async {
    emit(GinjalState(ginjalState: ViewData.loading()));
    final result = await getListGinjalUsecase.call(SearchParams(date: date));

    return result.fold(
      (failure) => emit(
        GinjalState(
          ginjalState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(GinjalState(ginjalState: ViewData.loaded(data: data)));
      },
    );
  }

  Future<void> addGinjal(String date, int type, double total) async {
    emit(GinjalState(ginjalState: ViewData.loading()));
    final result = await addGinjalUsecase.call(
      AddParams(
        data: GinjalEntity(date: date, type: type, total: total),
      ),
    );

    return result.fold(
      (failure) => emit(
        GinjalState(
          ginjalState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(GinjalState(ginjalState: ViewData.loaded(data: data)));
      },
    );
  }
}
