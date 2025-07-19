import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/article_entity.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
abstract class Article with _$Article {
  const Article._();

  factory Article({
    required int id,
    @JsonKey(name: 'judul') required String title,
    String? image,
    required String content,
    String? audio,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  ArticleEntity toEntity() => ArticleEntity(
    id: id,
    title: title,
    image: image,
    content: content,
    audio: audio,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
