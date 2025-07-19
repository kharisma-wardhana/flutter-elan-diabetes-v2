import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final int id;
  final String title;
  final String content;
  final String? image;
  final String? audio;
  final String createdAt;
  final String updatedAt;

  const ArticleEntity({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    this.audio,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        image,
        audio,
        createdAt,
        updatedAt,
      ];
}
