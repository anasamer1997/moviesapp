import 'package:moviesapp/data/model/Movies/movies_model.dart';

import '../../data/remote/api_endPoints.dart';
import '../../data/remote/base_api_service.dart';
import '../../data/remote/netword_api_service.dart';
import 'movies_repo.dart';

class MovieRepoImp extends NewsRepo {
  final BaseApiService _apiService = NetworkApiService();
  @override
  Future getMoviesPaginationData(String moviesType, int page) async {
    try {
      MoviesModel response =
          await _apiService.getPopularMoviesPaginationResponse(
              ApiEndPoints().getMoviesList, moviesType, page);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
