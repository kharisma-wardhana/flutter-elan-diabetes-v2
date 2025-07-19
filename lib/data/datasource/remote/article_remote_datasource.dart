import '../../../core/api_service.dart';
import '../../../core/error.dart';
import '../../model/article/article.dart';

abstract class ArticleRemoteDatasource {
  Future<List<Article>> getListArticles();
  Future<Article> getDetailArticle(int id);
}

class ArticleRemoteDatasourceImpl implements ArticleRemoteDatasource {
  final ApiService apiService;

  const ArticleRemoteDatasourceImpl({required this.apiService});

  @override
  Future<List<Article>> getListArticles() async {
    try {
      final response = await apiService.fetchData('/articles');
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<Article> getDetailArticle(int id) async {
    try {
      final response = await apiService.fetchData('/articles/$id');
      final responseData = response.data as Map<String, dynamic>;
      return Article.fromJson(responseData);
    } on ServerException {
      rethrow;
    }
  }
}
