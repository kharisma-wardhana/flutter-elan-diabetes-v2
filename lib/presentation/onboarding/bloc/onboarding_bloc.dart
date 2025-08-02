import 'package:elan/core/constant.dart';
import 'package:elan/domain/usecase/activity/add_activity_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/usecase/gula_darah/add_gula_darah_usecase.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final FlutterSecureStorage secureStorage;
  final AddGulaDarahUsecase addGulaDarahUsecase;
  final AddActivityUsecase addActivityUsecase;

  OnboardingBloc({
    required this.secureStorage,
    required this.addGulaDarahUsecase,
    required this.addActivityUsecase,
  }) : super(const OnboardingState.initial()) {
    on<AddGulaDarahEvent>((event, emit) async {
      emit(const OnboardingState.loading());
      try {
        final userID = await secureStorage.read(key: 'user_id');
        final result = await addGulaDarahUsecase.call({
          'gulaDarahPuasa': event.gulaDarahPuasa,
          'gulaDarahSewaktu': event.gulaDarahSewaktu,
          'userID': userID ?? '',
        });
        if (event.gulaDarahPuasa.isEmpty && event.gulaDarahSewaktu.isEmpty) {
          emit(const OnboardingState.error('Gula darah tidak boleh kosong'));
          return;
        }
        var state = const OnboardingState.successNormal();
        if ((event.gulaDarahSewaktu.isNotEmpty &&
                int.parse(event.gulaDarahSewaktu) > 180) ||
            (event.gulaDarahPuasa.isNotEmpty &&
                int.parse(event.gulaDarahPuasa) > 125)) {
          state = const OnboardingState.successDiabetes(typeDM);
        }
        if ((event.gulaDarahPuasa.isNotEmpty &&
                int.parse(event.gulaDarahPuasa) > 100) &&
            (event.gulaDarahPuasa.isNotEmpty &&
                int.parse(event.gulaDarahPuasa) <= 125)) {
          state = const OnboardingState.successDiabetes(typePreDM);
        }
        result.fold(
          (failure) => emit(OnboardingState.error(failure.message)),
          (_) => emit(state),
        );
      } catch (e) {
        emit(OnboardingState.error(e.toString()));
      }
    });
    on<AddActivityEvent>((event, emit) async {
      emit(const OnboardingState.loading());
      try {
        final result = await addActivityUsecase.call({
          'name': event.activityName,
        });
        result.fold(
          (failure) => emit(OnboardingState.error(failure.message)),
          (_) => emit(const OnboardingState.success()),
        );
      } catch (e) {
        emit(OnboardingState.error(e.toString()));
      }
    });
  }
}
