abstract class BaseApiService {
  final String baseUrl = "https://api.themoviedb.org/3/trending/movie/";
  final String apiKey = "78f2aacd59861893fa9be30714e749d6";

  Future<dynamic> getPopularMoviesPaginationResponse(
      String url, String movieType, int page);
}
