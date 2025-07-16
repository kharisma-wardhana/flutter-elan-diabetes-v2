import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/gula_darah/usecase/add_gula_darah_usecase.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final AddGulaDarahUsecase addGulaDarahUsecase;

  OnboardingBloc(this.addGulaDarahUsecase)
    : super(const OnboardingState.initial()) {
    on<AddGulaDarahPuasaEvent>((event, emit) async {
      emit(const OnboardingState.loading());
      try {
        final result = await addGulaDarahUsecase.call({
          'gulaDarah': event.gulaDarahPuasa,
        });
        result.fold(
          (failure) => emit(OnboardingState.error(failure.message)),
          (_) => emit(const OnboardingState.success()),
        );
      } catch (e) {
        emit(OnboardingState.error(e.toString()));
      }
    });

    on<AddGulaDarahSewaktuEvent>((event, emit) async {
      emit(const OnboardingState.loading());
      try {
        final result = await addGulaDarahUsecase.call({
          'gulaDarah': event.gulaDarahSewaktu,
        });
        result.fold(
          (failure) => emit(OnboardingState.error(failure.message)),
          (_) => emit(const OnboardingState.success()),
        );
      } catch (e) {
        emit(OnboardingState.error(e.toString()));
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
