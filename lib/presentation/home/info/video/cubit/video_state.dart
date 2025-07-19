import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../domain/entities/video_entity.dart';

class VideoState extends Equatable {
  final ViewData<List<VideoEntity>> videoState;

  const VideoState({required this.videoState});

  @override
  List<Object?> get props => [videoState];
}
