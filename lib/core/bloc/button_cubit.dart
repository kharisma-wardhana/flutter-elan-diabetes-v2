import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../usecase.dart';
import 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitial());

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoading());
    try {
      Either returnedData = await usecase.call(params);
      returnedData.fold(
        (error) {
          emit(ButtonError(message: error));
        },
        (data) {
          emit(ButtonSuccess());
        },
      );
    } catch (e) {
      emit(ButtonError(message: e.toString()));
    }
  }
}
