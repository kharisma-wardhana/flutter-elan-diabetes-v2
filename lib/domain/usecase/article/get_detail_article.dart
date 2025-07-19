import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/article_entity.dart';
import '../../repository/article_repository.dart';

class GetDetailArticle extends UseCase<ArticleEntity, int> {
  final ArticleRepository articleRepo;

  const GetDetailArticle({required this.articleRepo});

  @override
  Future<Either<Failure, ArticleEntity>> call(int params) async {
    return await articleRepo.getDetailArticle(params);
  }
}
