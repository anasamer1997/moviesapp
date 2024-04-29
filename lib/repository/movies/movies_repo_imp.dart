import '../../data/remote/api_endPoints.dart';
import '../../data/remote/base_api_service.dart';
import '../../data/remote/netword_api_service.dart';
import 'movies_repo.dart';

class MovieRepoImp extends NewsRepo {
  final BaseApiService _apiService = NetworkApiService();
  static const int _pageSize = 10;

  @override
  Future getMoviesPaginationData(String newsType, int page) async {
    try {
      dynamic response = await _apiService.getPopularMoviesPaginationResponse(
          ApiEndPoints().getNewsList, _pageSize, page);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  getNewsData(String newsType) {}
}
