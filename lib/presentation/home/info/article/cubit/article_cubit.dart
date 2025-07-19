import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../core/usecase.dart';
import '../../../../../domain/usecase/article/get_detail_article.dart';
import '../../../../../domain/usecase/article/get_list_articles.dart';
import 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final GetDetailArticle getDetailArticle;
  final GetListArticles getListArticles;

  ArticleCubit({required this.getListArticles, required this.getDetailArticle})
    : super(ArticleState(articleState: ViewData.initial()));

  Future<void> getAll() async {
    emit(ArticleState(articleState: ViewData.loading()));
    final result = await getListArticles.call(NoParams());

    return result.fold(
      (failure) => emit(
        ArticleState(
          articleState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(ArticleState(articleState: ViewData.loaded(data: data)));
      },
    );
  }

  Future<void> getDetail(int id) async {
    emit(ArticleState(articleState: ViewData.loading()));
    final result = await getDetailArticle.call(id);

    return result.fold(
      (failure) => emit(
        ArticleState(
          articleState: ViewData.error(
            message: failure.message,
            failure: failure,
          ),
        ),
      ),
      (data) {
        emit(ArticleState(articleState: ViewData.loaded(data: data)));
      },
    );
  }
}
