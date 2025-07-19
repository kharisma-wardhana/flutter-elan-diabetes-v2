import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/usecase/video/get_list_video_usecase.dart';
import 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final GetListVideoUsecase getListVideoUseCase;

  VideoCubit({required this.getListVideoUseCase})
    : super(VideoState(videoState: ViewData.initial()));

  Future<void> getAllVideo() async {
    emit(VideoState(videoState: ViewData.loading()));
    final result = await getListVideoUseCase.call(NoParams());

    return result.fold(
      (failure) => emit(
        VideoState(
          videoState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(VideoState(videoState: ViewData.loaded(data: data)));
      },
    );
  }
}
