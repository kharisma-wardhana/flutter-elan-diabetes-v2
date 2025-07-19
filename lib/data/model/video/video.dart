import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/video_entity.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
abstract class Video with _$Video {
  const Video._();
  factory Video({
    required int id,
    @JsonKey(name: 'judul') required String title,
    @JsonKey(name: 'desc') required String desc,
    @JsonKey(name: 'url') required String url,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  VideoEntity toEntity() => VideoEntity(title: title, desc: desc, url: url);
}
