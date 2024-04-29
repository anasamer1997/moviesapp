import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import '../../data/remote/app_exception.dart';
import '../../data/remote/base_api_service.dart';

class NetworkApiService extends BaseApiService {
  final dio = Dio();

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.data);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
      case 404:
        dynamic responseJson = jsonDecode(response.data);
        throw UnauthorisedException(responseJson['message']);
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }

  @override
  Future getPopularMoviesPaginationResponse(
      String url, int pageSize, int page) async {
    dynamic responseJson;
    try {
      var query = {
        "apiKey": apiKey,
        "pageSize": pageSize.toString(),
        "page": page.toString()
      };
      final response = await dio.get(baseUrl + url, queryParameters: query);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }
}
