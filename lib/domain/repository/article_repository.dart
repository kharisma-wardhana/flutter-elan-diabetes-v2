import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../entities/article_entity.dart';

abstract class ArticleRepository {
  const ArticleRepository();

  Future<Either<Failure, List<ArticleEntity>>> getListArticles();

  Future<Either<Failure, ArticleEntity>> getDetailArticle(int id);
}
