import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/usecase/assesment/get_assesment_usecase.dart';
import 'assesment_state.dart';

class AssesmentCubit extends Cubit<AssesmentState> {
  final GetAssesmentUsecase getAssesmentUsecase;

  AssesmentCubit({required this.getAssesmentUsecase})
    : super(AssesmentState(assesmentState: ViewData.initial()));

  Future<void> getAssesment() async {
    emit(AssesmentState(assesmentState: ViewData.loading()));
    final result = await getAssesmentUsecase(NoParams());
    result.fold(
      (failure) => emit(
        AssesmentState(
          assesmentState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (assesment) => emit(
        AssesmentState(assesmentState: ViewData.loaded(data: assesment)),
      ),
    );
  }
}
