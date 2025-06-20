import 'package:clean_app/core/constants/constants.dart';
import 'package:clean_app/features/daily_news/data/models/article.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query('country') String? country,
    @Query('category') String? category,
    @Query('apiKey') String? apiKey,
  });
}
