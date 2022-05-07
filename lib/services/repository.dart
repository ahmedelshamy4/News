import 'package:dartz/dartz.dart';

import '../model/article.dart';
import '../model/error_result.dart';

///THIS ABSTRACT CLASS FOR SHOWING SERVICES METHODS
abstract class ArticleServices {
  Future<Either<List<Article>, ErrorResult>> getTopHeadlineArticles(
      {required String country});

  Future<Either<List<Article>, ErrorResult>> getArticlesByCategory(
      {required String country, required String category});
}
