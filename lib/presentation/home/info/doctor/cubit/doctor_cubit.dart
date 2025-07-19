import 'package:elan/presentation/home/info/doctor/cubit/doctor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/usecase/doctor/get_all_doctor_usecase.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final GetAllDoctorUsecase getAllDoctorUseCase;

  DoctorCubit({required this.getAllDoctorUseCase})
    : super(DoctorState(doctorState: ViewData.initial()));

  Future<void> getAllDoctor() async {
    emit(DoctorState(doctorState: ViewData.loading()));
    final result = await getAllDoctorUseCase.call(NoParams());

    return result.fold(
      (failure) => emit(
        DoctorState(
          doctorState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(DoctorState(doctorState: ViewData.loaded(data: data)));
      },
    );
  }
}
