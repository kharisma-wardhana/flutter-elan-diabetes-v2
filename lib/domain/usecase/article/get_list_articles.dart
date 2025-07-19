import 'package:dartz/dartz.dart';
import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/article_entity.dart';
import '../../repository/article_repository.dart';

class GetListArticles extends UseCase<List<ArticleEntity>, NoParams> {
  final ArticleRepository articleRepo;

  const GetListArticles({required this.articleRepo});

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(params) async {
    return await articleRepo.getListArticles();
  }
}
