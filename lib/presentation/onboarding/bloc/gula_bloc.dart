import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/gula/usecase/add_gula_darah_usecase.dart';
import 'gula_event.dart';
import 'gula_state.dart';

class GulaBloc extends Bloc<GulaEvent, GulaState> {
  final AddGulaDarahUsecase addGulaDarahUsecase;

  GulaBloc(this.addGulaDarahUsecase) : super(const GulaState.initial()) {
    on<AddGulaDarahPuasaEvent>((event, emit) async {
      emit(const GulaState.loading());
      try {
        final result = await addGulaDarahUsecase.call({
          'gulaDarah': event.gulaDarahPuasa,
        });
        result.fold(
          (failure) => emit(GulaState.error(failure.message)),
          (_) => emit(const GulaState.success()),
        );
      } catch (e) {
        emit(GulaState.error(e.toString()));
      }
    });

    on<AddGulaDarahSewaktuEvent>((event, emit) async {
      emit(const GulaState.loading());
      try {
        final result = await addGulaDarahUsecase.call({
          'gulaDarah': event.gulaDarahSewaktu,
        });
        result.fold(
          (failure) => emit(GulaState.error(failure.message)),
          (_) => emit(const GulaState.success()),
        );
      } catch (e) {
        emit(GulaState.error(e.toString()));
      }
    });

    on<GetGulaDarahEvent>((event, emit) async {
      // Logic to get Gula Darah data
    });

    on<CheckGulaDarahPuasaEvent>((event, emit) async {
      // Logic to check Gula Darah Puasa
    });

    on<CheckGulaDarahSewaktuEvent>((event, emit) async {
      // Logic to check Gula Darah Sewaktu
    });
  }
}
