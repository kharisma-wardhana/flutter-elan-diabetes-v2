import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';

class ArticleState extends Equatable {
  final ViewData articleState;

  const ArticleState({required this.articleState});

  @override
  List<Object?> get props => [articleState];
}
