import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/repository/article_repository.dart';
import '../datasource/remote/article_remote_datasource.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDatasource articleRemoteDatasource;

  ArticleRepositoryImpl({required this.articleRemoteDatasource});

  @override
  Future<Either<Failure, ArticleEntity>> getDetailArticle(int id) async {
    try {
      final article = await articleRemoteDatasource.getDetailArticle(id);
      return Right(article.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getListArticles() async {
    try {
      final articles = await articleRemoteDatasource.getListArticles();
      return Right(articles.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
